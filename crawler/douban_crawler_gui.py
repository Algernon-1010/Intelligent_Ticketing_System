#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Tkinter GUI for importing Douban movie data into this project's `movie` table.
"""

from __future__ import annotations

import logging
import queue
import threading
import tkinter as tk
from argparse import Namespace
from tkinter import messagebox, ttk

from douban_movie_crawler import (
    DEFAULT_IMAGE_DIR,
    DEFAULT_START_URL,
    MovieRepository,
    crawl_movies,
    download_poster,
)


class QueueLogHandler(logging.Handler):
    def __init__(self, log_queue: queue.Queue[str]) -> None:
        super().__init__()
        self.log_queue = log_queue

    def emit(self, record: logging.LogRecord) -> None:
        self.log_queue.put(self.format(record))


class DoubanCrawlerGui:
    def __init__(self, root: tk.Tk) -> None:
        self.root = root
        self.root.title("豆瓣电影数据抓取工具")
        self.root.geometry("900x680")
        self.root.minsize(820, 620)

        self.log_queue: queue.Queue[str] = queue.Queue()
        self.worker: threading.Thread | None = None

        self.start_url = tk.StringVar(value=DEFAULT_START_URL)
        self.pages = tk.StringVar(value="1")
        self.max_movies = tk.StringVar(value="25")
        self.interval = tk.StringVar(value="3")
        self.timeout = tk.StringVar(value="15")
        self.db_host = tk.StringVar(value="localhost")
        self.db_port = tk.StringVar(value="3305")
        self.db_name = tk.StringVar(value="movie")
        self.db_user = tk.StringVar(value="root")
        self.db_password = tk.StringVar(value="root")
        self.image_dir = tk.StringVar(value=DEFAULT_IMAGE_DIR)
        self.image_url_prefix = tk.StringVar(value="/file/upload/movies")
        self.download_posters = tk.BooleanVar(value=True)
        self.dry_run = tk.BooleanVar(value=True)
        self.overwrite_stats = tk.BooleanVar(value=False)
        self.fetch_details = tk.BooleanVar(value=False)

        self._setup_logging()
        self._build_ui()
        self.root.after(150, self._poll_logs)

    def _setup_logging(self) -> None:
        handler = QueueLogHandler(self.log_queue)
        handler.setFormatter(logging.Formatter("%(asctime)s %(levelname)s %(message)s", "%H:%M:%S"))
        root_logger = logging.getLogger()
        root_logger.setLevel(logging.INFO)
        root_logger.addHandler(handler)

    def _build_ui(self) -> None:
        self.root.columnconfigure(0, weight=1)
        self.root.rowconfigure(2, weight=1)

        source = ttk.LabelFrame(self.root, text="抓取设置", padding=12)
        source.grid(row=0, column=0, padx=14, pady=(14, 8), sticky="ew")
        source.columnconfigure(1, weight=1)
        source.columnconfigure(3, weight=1)

        self._entry(source, "列表地址", self.start_url, 0, 0, width=72, columnspan=3)
        self._entry(source, "页数", self.pages, 1, 0)
        self._entry(source, "抓取数量", self.max_movies, 1, 2)
        self._entry(source, "请求间隔/秒", self.interval, 2, 0)
        self._entry(source, "超时/秒", self.timeout, 2, 2)

        options = ttk.Frame(source)
        options.grid(row=3, column=1, columnspan=3, sticky="w", pady=(8, 0))
        ttk.Checkbutton(options, text="下载海报到项目目录", variable=self.download_posters).pack(side="left", padx=(0, 22))
        ttk.Checkbutton(options, text="仅预览，不写数据库", variable=self.dry_run).pack(side="left", padx=(0, 22))
        ttk.Checkbutton(options, text="抓取详情页", variable=self.fetch_details).pack(side="left", padx=(0, 22))
        ttk.Checkbutton(options, text="更新已有电影评分人数", variable=self.overwrite_stats).pack(side="left")

        storage = ttk.LabelFrame(self.root, text="存储设置", padding=12)
        storage.grid(row=1, column=0, padx=14, pady=8, sticky="ew")
        storage.columnconfigure(1, weight=1)
        storage.columnconfigure(3, weight=1)

        self._entry(storage, "数据库地址", self.db_host, 0, 0)
        self._entry(storage, "端口", self.db_port, 0, 2)
        self._entry(storage, "数据库名", self.db_name, 1, 0)
        self._entry(storage, "账号", self.db_user, 1, 2)
        self._entry(storage, "密码", self.db_password, 2, 0, show="*")
        self._entry(storage, "海报目录", self.image_dir, 3, 0, columnspan=3, width=64)
        self._entry(storage, "海报访问路径", self.image_url_prefix, 4, 0, columnspan=3, width=64)

        log_frame = ttk.LabelFrame(self.root, text="运行日志", padding=12)
        log_frame.grid(row=2, column=0, padx=14, pady=8, sticky="nsew")
        log_frame.columnconfigure(0, weight=1)
        log_frame.rowconfigure(0, weight=1)

        self.log_text = tk.Text(log_frame, height=18, wrap="word", state="disabled")
        self.log_text.grid(row=0, column=0, sticky="nsew")
        scrollbar = ttk.Scrollbar(log_frame, command=self.log_text.yview)
        scrollbar.grid(row=0, column=1, sticky="ns")
        self.log_text.configure(yscrollcommand=scrollbar.set)

        actions = ttk.Frame(self.root, padding=(14, 4, 14, 14))
        actions.grid(row=3, column=0, sticky="ew")
        actions.columnconfigure(0, weight=1)
        self.progress = ttk.Progressbar(actions, mode="indeterminate")
        self.progress.grid(row=0, column=0, sticky="ew", padx=(0, 12))
        self.start_button = ttk.Button(actions, text="开始抓取", command=self.start)
        self.start_button.grid(row=0, column=1)
        ttk.Button(actions, text="清空日志", command=self.clear_logs).grid(row=0, column=2, padx=(8, 0))

    def _entry(
        self,
        parent: ttk.Frame,
        label: str,
        variable: tk.StringVar,
        row: int,
        column: int,
        width: int = 22,
        columnspan: int = 1,
        show: str | None = None,
    ) -> None:
        ttk.Label(parent, text=label).grid(row=row, column=column, padx=(0, 8), pady=5, sticky="e")
        ttk.Entry(parent, textvariable=variable, width=width, show=show).grid(
            row=row,
            column=column + 1,
            columnspan=columnspan,
            padx=(0, 14),
            pady=5,
            sticky="ew",
        )

    def start(self) -> None:
        if self.worker and self.worker.is_alive():
            return
        try:
            args = self._build_args()
        except ValueError as exc:
            messagebox.showerror("参数错误", str(exc))
            return

        self.start_button.configure(state="disabled")
        self.progress.start(10)
        self._append_log("开始任务...\n")
        self.worker = threading.Thread(target=self._run_import, args=(args,), daemon=True)
        self.worker.start()

    def _build_args(self) -> Namespace:
        def int_value(name: str, value: str, minimum: int = 1) -> int:
            try:
                parsed = int(value)
            except ValueError as exc:
                raise ValueError(f"{name} 必须是整数") from exc
            if parsed < minimum:
                raise ValueError(f"{name} 不能小于 {minimum}")
            return parsed

        def float_value(name: str, value: str, minimum: float = 0.0) -> float:
            try:
                parsed = float(value)
            except ValueError as exc:
                raise ValueError(f"{name} 必须是数字") from exc
            if parsed < minimum:
                raise ValueError(f"{name} 不能小于 {minimum}")
            return parsed

        return Namespace(
            start_url=self.start_url.get().strip(),
            pages=int_value("页数", self.pages.get()),
            max_movies=int_value("抓取数量", self.max_movies.get()),
            interval=float_value("请求间隔", self.interval.get()),
            timeout=float_value("超时时间", self.timeout.get(), 1.0),
            fetch_details=self.fetch_details.get(),
            max_detail_errors=2,
            download_posters=self.download_posters.get(),
            image_dir=self.image_dir.get().strip(),
            image_url_prefix=self.image_url_prefix.get().strip(),
            dry_run=self.dry_run.get(),
            overwrite_stats=self.overwrite_stats.get(),
            db_host=self.db_host.get().strip(),
            db_port=int_value("数据库端口", self.db_port.get()),
            db_name=self.db_name.get().strip(),
            db_user=self.db_user.get().strip(),
            db_password=self.db_password.get(),
        )

    def _run_import(self, args: Namespace) -> None:
        repository = None if args.dry_run else MovieRepository(args)
        inserted = updated = skipped = previewed = 0
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
                    previewed += 1
                    logging.info("预览 %s | %s | %s | %s", movie.title, movie.release_date, movie.genres, movie.score)
                    continue
                result = repository.upsert(movie)
                inserted += result == "inserted"
                updated += result == "updated"
                logging.info("%s %s (%s)", "新增" if result == "inserted" else "更新", movie.title, movie.release_date)
            logging.info("完成：新增=%s 更新=%s 预览=%s 跳过=%s", inserted, updated, previewed, skipped)
        except Exception:
            logging.exception("任务失败")
        finally:
            if repository:
                repository.close()
            self.log_queue.put("__TASK_DONE__")

    def _poll_logs(self) -> None:
        while True:
            try:
                message = self.log_queue.get_nowait()
            except queue.Empty:
                break
            if message == "__TASK_DONE__":
                self.progress.stop()
                self.start_button.configure(state="normal")
                self._append_log("任务结束。\n")
            else:
                self._append_log(message + "\n")
        self.root.after(150, self._poll_logs)

    def _append_log(self, message: str) -> None:
        self.log_text.configure(state="normal")
        self.log_text.insert("end", message)
        self.log_text.see("end")
        self.log_text.configure(state="disabled")

    def clear_logs(self) -> None:
        self.log_text.configure(state="normal")
        self.log_text.delete("1.0", "end")
        self.log_text.configure(state="disabled")


def main() -> None:
    root = tk.Tk()
    DoubanCrawlerGui(root)
    root.mainloop()


if __name__ == "__main__":
    main()
