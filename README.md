# Intelligent Ticketing System

基于 Java Servlet/JSP、MySQL 和 Tomcat 的电影购票系统。当前版本已经接入云端 API AI 客服，后续智能化功能会继续添加。

## 当前功能

- 用户注册、登录和个人中心
- 电影、影院、影厅和排片管理
- 电影搜索、电影详情和评论
- 选座、购票、支付状态和订单查询
- AI 客服：在公共导航栏页面右下角打开聊天窗口
  - 调用 OpenAI Chat Completions 格式的云端接口
  - 支持替换为其他兼容 `/v1/chat/completions` 的服务
  - 查询电影、场次和余票时，会读取项目数据库中的公开数据作为回答上下文

## 运行环境

- Java 8
- Tomcat 8.5 或 Tomcat 9
- MySQL 8
- IntelliJ IDEA（传统 Java Web 项目）

## 快速启动

1. 用 IntelliJ IDEA 打开 `film.iml`，配置 Java 8 和 Tomcat。
2. 启动 MySQL，在测试环境执行根目录的 `movie.sql`。该脚本会删除并重建 `movie` 数据库，请确认目标数据库可以被重建。
3. 检查 `src/com/movie/util/JdbcUtil.java` 中的数据库连接配置。
4. 在 Tomcat 运行配置中部署 `film:Web exploded`，上下文路径设置为 `/`。
5. 启动 Tomcat，访问 `http://localhost:8080/`。

## AI 客服配置

AI 客服通过服务端调用云端 API，浏览器不会接触 API 密钥。启动 Tomcat 前，在 IDEA 的 Tomcat 运行配置中设置：

```text
AI_API_URL=https://api.openai.com/v1/chat/completions
AI_API_KEY=你的API密钥
AI_MODEL=gpt-5.2
```

也支持 `OPENAI_API_KEY`。详细配置和接口示例见 [AI客服配置说明.md](AI客服配置说明.md)。

接口地址：

```text
POST /ai/chat
Content-Type: application/json

{"message":"怎么查询今晚的电影场次？"}
```

不要把真实 API 密钥提交到 Git 仓库。

## 目录说明

```text
src/                     Java Servlet、Bean、DAO 和业务服务
WebContent/              JSP 页面、静态资源和 Web 依赖
WebContent/WEB-INF/lib/  项目运行所需的第三方 JAR
movie.sql                MySQL 表结构和示例数据
film.iml                 IntelliJ IDEA 模块文件
```

## 后续计划

- 将订单查询、退票和座位推荐接入 AI 工具调用
- 增加更准确的实时场次筛选和推荐
- 增加客服会话记录和后台统计
