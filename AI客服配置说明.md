# AI 客服配置说明

项目已经加入传统 Servlet/JSP 兼容的云端 API AI 客服模块。启动 Tomcat 后，打开任意包含公共导航栏的页面，右下角会出现“AI客服”。

## 启动项目

1. 用 IntelliJ IDEA 打开 `film.iml`，项目 SDK 选择 Java 8。当前工程是传统 Web 模块，建议使用 Tomcat 8.5 或 Tomcat 9。
2. 启动 MySQL 8，并在本地测试库中执行项目根目录的 `movie.sql`。脚本会删除并重建 `movie` 数据库，请确认连接的是测试数据库。
3. 检查 `src/com/movie/util/JdbcUtil.java` 中的 MySQL 用户名和密码，原项目默认是 `root` / `root`。
4. 在 IntelliJ 的 Tomcat 运行配置中部署 `film:Web exploded`，上下文路径设置为 `/`，再启动 Tomcat。
5. 在浏览器打开 `http://localhost:8080/`。进入页面后点击右下角“AI客服”。

网站和数据库可以继续在本机运行，AI回答由下面配置的云端 API 生成。

## OpenAI API

默认配置调用 OpenAI 的 Chat Completions 接口。请在启动 Tomcat 的运行环境中设置 API 密钥：

```text
AI_API_URL=https://api.openai.com/v1/chat/completions
AI_API_KEY=你的OpenAI API密钥
AI_MODEL=gpt-5.2
```

OpenAI 官方常用的 `OPENAI_API_KEY` 环境变量也支持。也可以直接修改 `src/ai.properties` 中的 `ai.api.key`、`ai.api.url`、`ai.model`。环境变量优先级高于配置文件；密钥不要提交到代码仓库。

在 IntelliJ IDEA 中运行项目时，也可以打开 Run/Debug Configurations，在 Environment variables 中填写 `AI_API_KEY`、`AI_API_URL` 和 `AI_MODEL`，然后重新启动 Tomcat。

## 其他兼容接口

如果使用其他支持 OpenAI Chat Completions 格式的服务，只需替换 `AI_API_URL`、`AI_API_KEY` 和 `AI_MODEL`，Java 代码无需修改。

## 接口

```text
POST /ai/chat
Content-Type: application/json

{"message":"怎么查询今晚的电影场次？"}
```

成功响应：

```json
{"code":0,"data":"客服回答内容"}
```
