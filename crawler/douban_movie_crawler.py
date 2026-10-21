#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Import public Douban movie pages into this project's `movie` table.

The script uses normal public HTTP requests with throttling. It does not log in,
solve captchas, or bypass access controls.
"""

from __future__ import annotations

import argparse
import hashlib
import logging
import os
import random
import re
import time
from dataclasses import dataclass
from datetime import datetime
from typing import Iterable
from urllib.parse import urljoin

import pymysql
import requests
from bs4 import BeautifulSoup


LOGGER = logging.getLogger("douban_movie_crawler")

DEFAULT_START_URL = "https://movie.douban.com/top250"
DEFAULT_HEADERS = {
    "User-Agent": (
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
        "AppleWebKit/537.36 (KHTML, like Gecko) "
        "Chrome/125.0 Safari/537.36"
    ),
    "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.7",
}
PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), os.pardir))
DEFAULT_IMAGE_DIR = os.path.join(PROJECT_ROOT, "WebContent", "file", "upload", "movies")


@dataclass
class MovieItem:
    url: str
    title: str = ""
    foreign_title: str = ""
    directors: str = ""
    actors: str = ""
    detail: str = ""
    duration: str = ""
    genres: str = ""
    score: float = 0.0
    comment_count: int = 0
    release_date: str = ""
    country: str = ""
    poster_url: str = ""
    poster_path: str = ""


def clean_text(value: str | None) -> str:
    if not value:
        return ""
    return re.sub(r"\s+", " ", value.replace("\xa0", " ")).strip()


def first_match(pattern: str, text: str) -> str:
    matched = re.search(pattern, text, flags=re.MULTILINE)
    return clean_text(matched.group(1)) if matched else ""


def parse_date(value: str) -> str:
    matched = re.search(r"\d{4}-\d{1,2}-\d{1,2}", value or "")
    if not matched:
        year = re.search(r"\d{4}", value or "")
        return f"{year.group(0)}-01-01" if year else "1970-01-01"
    try:
        return datetime.strptime(matched.group(0), "%Y-%m-%d").strftime("%Y-%m-%d")
    except ValueError:
        return "1970-01-01"


def parse_score(value: str) -> float:
    try:
        return round(float(value), 1)
    except (TypeError, ValueError):
        return 0.0


def parse_int(value: str) -> int:
    digits = re.sub(r"\D", "", value or "")
    return int(digits) if digits else 0


def clean_truncated(value: str) -> str:
    value = clean_text(value)
    value = re.sub(r"\s*主\.{3}.*$", "", value)
    return value.replace("...", "").strip()


def normalize_movie(movie: MovieItem) -> MovieItem:
    movie.title = clean_text(movie.title)
    movie.foreign_title = clean_text(movie.foreign_title) or movie.title
    movie.directors = clean_truncated(movie.directors) or "未知"
    movie.actors = clean_truncated(movie.actors) or "未知:未知"
    movie.detail = clean_text(movie.detail)
    movie.duration = clean_text(movie.duration) or "0分钟"
    movie.genres = clean_text(movie.genres) or "未知"
    movie.release_date = parse_date(movie.release_date)
    movie.country = clean_text(movie.country) or "未知"
    movie.poster_url = clean_text(movie.poster_url)
    return movie


def build_top250_page_urls(start_url: str, pages: int) -> list[str]:
    if "top250" not in start_url:
        return [start_url]
    return [f"{start_url}?start={index * 25}&filter=" for index in range(pages)]


class DoubanCrawler:
    def __init__(self, interval: float, timeout: float) -> None:
        self.interval = interval
        self.timeout = timeout
        self.session = requests.Session()
        self.session.headers.update(DEFAULT_HEADERS)

    def fetch(self, url: str) -> str:
        LOGGER.info("Fetching %s", url)
        response = self.session.get(url, timeout=self.timeout)
        response.raise_for_status()
        time.sleep(self.interval + random.uniform(0.5, 1.5))
        return response.text

    def parse_list_page(self, url: str) -> list[MovieItem]:
        soup = BeautifulSoup(self.fetch(url), "html.parser")
        items: list[MovieItem] = []
        for node in soup.select(".grid_view .item"):
            link = node.select_one(".hd a")
            if not link or not link.get("href"):
                continue
            titles = [clean_text(span.get_text()) for span in node.select(".hd .title")]
            foreign_title = ""
            if len(titles) > 1:
                foreign_title = clean_text(titles[1].lstrip("/"))
            poster = node.select_one(".pic img")
            quote = node.select_one(".quote .inq")
            score = node.select_one(".rating_num")
            comments = node.select_one(".star span:last-child")
            info = node.select_one(".bd p")
            info_lines = []
            if info:
                info_lines = [clean_text(line) for line in info.get_text("\n").split("\n") if clean_text(line)]
            credit_line = info_lines[0] if info_lines else ""
            meta_line = info_lines[1] if len(info_lines) > 1 else ""

            director_text = ""
            actor_text = ""
            if credit_line:
                director_part = credit_line.split("主演:")[0]
                director_text = clean_truncated(director_part.replace("导演:", ""))
                if "主演:" in credit_line:
                    actor_part = clean_text(credit_line.split("主演:", 1)[1])
                    actor_names = [
                        clean_truncated(name)
                        for name in re.split(r"\s*/\s*", actor_part)
                        if name and "..." not in name
                    ]
                    actor_text = ",".join(f"{name}:未知" for name in actor_names[:8])

            release_date = ""
            country = ""
            genres = ""
            if meta_line:
                meta_parts = [clean_text(part) for part in meta_line.split("/") if clean_text(part)]
                release_date = parse_date(meta_parts[0]) if meta_parts else ""
                country = meta_parts[1] if len(meta_parts) > 1 else ""
                genres = meta_parts[2] if len(meta_parts) > 2 else ""
            items.append(
                MovieItem(
                    url=urljoin(url, link["href"]),
                    title=titles[0] if titles else "",
                    foreign_title=foreign_title,
                    directors=director_text,
                    actors=actor_text,
                    detail=clean_text(quote.get_text()) if quote else "",
                    genres=genres,
                    score=parse_score(score.get_text()) if score else 0.0,
                    comment_count=parse_int(comments.get_text()) if comments else 0,
                    release_date=release_date,
                    country=country,
                    poster_url=poster.get("src", "") if poster else "",
                )
            )
        return items

    def parse_detail_page(self, item: MovieItem) -> MovieItem:
        soup = BeautifulSoup(self.fetch(item.url), "html.parser")
        info_text = clean_text(soup.select_one("#info").get_text("\n")) if soup.select_one("#info") else ""

        title_node = soup.select_one("h1 span[property='v:itemreviewed']")
        if title_node:
            item.title = clean_text(re.sub(r"\(\d{4}\)$", "", title_node.get_text()))

        directors = [clean_text(node.get_text()) for node in soup.select("a[rel='v:directedBy']")]
        actors = [clean_text(node.get_text()) for node in soup.select("a[rel='v:starring']")]
        genres = [clean_text(node.get_text()) for node in soup.select("span[property='v:genre']")]
        release_dates = [clean_text(node.get_text()) for node in soup.select("span[property='v:initialReleaseDate']")]

        summary = soup.select_one("span[property='v:summary']")
        runtime = soup.select_one("span[property='v:runtime']")
        score = soup.select_one("strong[property='v:average']")
        votes = soup.select_one("span[property='v:votes']")
        image = soup.select_one("img[rel='v:image']")

        item.directors = ",".join(directors) or item.directors
        item.actors = ",".join(f"{actor}:未知" for actor in actors[:8]) or item.actors
        item.genres = " ".join(genres) or item.genres
        parsed_release_date = parse_date(release_dates[0] if release_dates else info_text)
        if parsed_release_date != "1970-01-01" or not item.release_date:
            item.release_date = parsed_release_date
        item.detail = clean_text(summary.get_text()) if summary else item.detail
        item.duration = clean_text(runtime.get("content") or runtime.get_text()) if runtime else item.duration
        item.score = parse_score(score.get_text()) if score else item.score
        item.comment_count = parse_int(votes.get_text()) if votes else item.comment_count
        item.poster_url = image.get("src", item.poster_url) if image else item.poster_url
        item.country = first_match(r"制片国家/地区:\s*([^\n]+)", info_text) or item.country

        aliases = first_match(r"又名:\s*([^\n]+)", info_text)
        if not item.foreign_title and aliases:
            item.foreign_title = clean_text(aliases.split("/")[0])
        if not item.foreign_title:
            item.foreign_title = item.title
        if not item.duration:
            item.duration = "0分钟"
        return item


class MovieRepository:
    def __init__(self, args: argparse.Namespace) -> None:
        self.connection = pymysql.connect(
            host=args.db_host,
            port=args.db_port,
            user=args.db_user,
            password=args.db_password,
            database=args.db_name,
            charset="utf8mb4",
            autocommit=False,
            cursorclass=pymysql.cursors.DictCursor,
        )
        self.overwrite_stats = args.overwrite_stats

    def close(self) -> None:
        self.connection.close()

    def find_existing(self, movie: MovieItem) -> dict | None:
        sql = """
            SELECT movie_id, movie_commentCount
            FROM movie
            WHERE movie_cn_name = %s AND DATE(movie_releaseDate) = %s
            LIMIT 1
        """
        with self.connection.cursor() as cursor:
            cursor.execute(sql, (movie.title, movie.release_date))
            return cursor.fetchone()

    def upsert(self, movie: MovieItem) -> str:
        existing = self.find_existing(movie)
        if existing:
            self.update(existing, movie)
            return "updated"
        self.insert(movie)
        return "inserted"

    def insert(self, movie: MovieItem) -> None:
        sql = """
            INSERT INTO movie (
                movie_cn_name, movie_fg_name, movie_actor, movie_director,
                movie_detail, movie_duration, movie_type, movie_score,
                movie_boxOffice, movie_commentCount, movie_releaseDate,
                movie_picture, movie_country, movie_state
            )
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, NULL, %s, %s, %s, %s, 1)
        """
        values = (
            movie.title,
            movie.foreign_title,
            movie.actors,
            movie.directors,
            movie.detail,
            movie.duration,
            movie.genres,
            movie.score,
            movie.comment_count,
            movie.release_date,
            movie.poster_path or movie.poster_url,
            movie.country,
        )
        with self.connection.cursor() as cursor:
            cursor.execute(sql, values)
        self.connection.commit()

    def update(self, existing: dict, movie: MovieItem) -> None:
        should_update_count = self.overwrite_stats or int(existing.get("movie_commentCount") or 0) == 0
        sql = """
            UPDATE movie SET
                movie_fg_name = %s,
                movie_actor = %s,
                movie_director = %s,
                movie_detail = %s,
                movie_duration = %s,
                movie_type = %s,
                movie_score = %s,
                movie_commentCount = CASE WHEN %s THEN %s ELSE movie_commentCount END,
                movie_releaseDate = %s,
                movie_picture = %s,
                movie_country = %s,
                movie_state = 1
            WHERE movie_id = %s
        """
        values = (
            movie.foreign_title,
            movie.actors,
            movie.directors,
            movie.detail,
            movie.duration,
            movie.genres,
            movie.score,
            should_update_count,
            movie.comment_count,
            movie.release_date,
            movie.poster_path or movie.poster_url,
            movie.country,
            existing["movie_id"],
        )
        with self.connection.cursor() as cursor:
            cursor.execute(sql, values)
        self.connection.commit()


def download_poster(movie: MovieItem, image_dir: str, image_url_prefix: str, timeout: float) -> MovieItem:
    if not movie.poster_url:
        return movie
    os.makedirs(image_dir, exist_ok=True)
    extension = os.path.splitext(movie.poster_url.split("?")[0])[1].lower()
    if extension not in {".jpg", ".jpeg", ".png", ".webp"}:
        extension = ".jpg"
    digest = hashlib.md5(movie.poster_url.encode("utf-8")).hexdigest()
    filename = f"douban_{digest}{extension}"
    target = os.path.join(image_dir, filename)
    if not os.path.exists(target):
        headers = dict(DEFAULT_HEADERS)
        headers["Referer"] = "https://movie.douban.com/"
        try:
            response = requests.get(movie.poster_url, headers=headers, timeout=timeout)
            response.raise_for_status()
        except requests.RequestException as exc:
            LOGGER.warning("Poster download failed, keep remote url: %s (%s)", movie.poster_url, exc)
            movie.poster_path = movie.poster_url
            return movie
        with open(target, "wb") as poster_file:
            poster_file.write(response.content)
    movie.poster_path = f"{image_url_prefix.rstrip('/')}/{filename}"
    return movie


def crawl_movies(args: argparse.Namespace) -> Iterable[MovieItem]:
    crawler = DoubanCrawler(args.interval, args.timeout)
    seen_urls: set[str] = set()
    yielded = 0
    detail_errors = 0
    detail_disabled = not getattr(args, "fetch_details", False)
    max_detail_errors = getattr(args, "max_detail_errors", 2)
    page_urls = build_top250_page_urls(args.start_url, args.pages)
    for page_url in page_urls:
        try:
            list_items = crawler.parse_list_page(page_url)
        except requests.RequestException as exc:
            LOGGER.warning("List page fetch failed, skip page: %s (%s)", page_url, exc)
            continue
        for list_item in list_items:
            if yielded >= args.max_movies:
                return
            if list_item.url in seen_urls:
                continue
            seen_urls.add(list_item.url)
            yielded += 1
            if detail_disabled:
                yield normalize_movie(list_item)
                continue
            try:
                yield normalize_movie(crawler.parse_detail_page(list_item))
            except requests.RequestException as exc:
                detail_errors += 1
                LOGGER.warning("Detail page fetch failed, use list data: %s (%s)", list_item.url, exc)
                if detail_errors >= max_detail_errors:
                    detail_disabled = True
                    LOGGER.warning("Too many detail page failures; details disabled for the rest of this task.")
                yield normalize_movie(list_item)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Crawl Douban movie data into this project's MySQL database.")
    parser.add_argument("--start-url", default=DEFAULT_START_URL, help="Douban list page URL. Default: Top250.")
    parser.add_argument("--pages", type=int, default=1, help="Pages to crawl for Douban Top250, 25 movies per page.")
    parser.add_argument("--max-movies", type=int, default=25, help="Maximum movie detail pages to import.")
    parser.add_argument("--interval", type=float, default=3.0, help="Base delay in seconds between page requests.")
    parser.add_argument("--timeout", type=float, default=15.0, help="HTTP timeout in seconds.")
    parser.add_argument("--fetch-details", action="store_true", help="Also fetch each movie detail page. Slower and easier to be rate-limited.")
    parser.add_argument("--max-detail-errors", type=int, default=2, help="Disable detail fetching after this many failures.")
    parser.add_argument("--download-posters", action="store_true", help="Download posters into the project's WebContent/file/upload/movies.")
    parser.add_argument("--image-dir", default=DEFAULT_IMAGE_DIR)
    parser.add_argument("--image-url-prefix", default="/file/upload/movies")
    parser.add_argument("--dry-run", action="store_true", help="Only print cleaned data, do not write database.")
    parser.add_argument("--overwrite-stats", action="store_true", help="Overwrite existing movie_commentCount on updates.")
    parser.add_argument("--db-host", default="localhost")
    parser.add_argument("--db-port", type=int, default=3306)
    parser.add_argument("--db-name", default="movie")
    parser.add_argument("--db-user", default="root")
    parser.add_argument("--db-password", default="root")
    return parser.parse_args()


def main() -> None:
    logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")
    args = parse_args()

    repository = None if args.dry_run else MovieRepository(args)
    inserted = updated = skipped = 0
    try:
        for index, movie in enumerate(crawl_movies(args), start=1):
            if index > args.max_movies:
                break
            if not movie.title:
                skipped += 1
                continue
            if args.download_posters and not args.dry_run:
                movie = download_poster(movie, args.image_dir, args.image_url_prefix, args.timeout)
            if args.dry_run:
                LOGGER.info("DRY RUN %s", movie)
                continue
            result = repository.upsert(movie)
            inserted += result == "inserted"
            updated += result == "updated"
            LOGGER.info("%s %s (%s)", result.upper(), movie.title, movie.release_date)
    finally:
        if repository:
            repository.close()

    LOGGER.info("Done. inserted=%s updated=%s skipped=%s", inserted, updated, skipped)


if __name__ == "__main__":
    main()
