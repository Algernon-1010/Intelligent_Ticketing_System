package com.movie.servlet;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.movie.bean.Cinema;
import com.movie.bean.Hall;
import com.movie.bean.Movie;
import com.movie.bean.Schedule;
import com.movie.service.MovieService;
import com.movie.service.ScheduleService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

/** 传统 Servlet/JSP 项目的影院 AI 客服接口。 */
@WebServlet("/ai/chat")
public class AiChatServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String DEFAULT_URL = "https://api.openai.com/v1/chat/completions";
    private static final String DEFAULT_MODEL = "gpt-5.2";
    private static final int MAX_MESSAGE_LENGTH = 2000;
    private static final int MAX_MOVIES_IN_CONTEXT = 20;
    private static final int MAX_SCHEDULES_IN_CONTEXT = 30;
    private static final String SYSTEM_PROMPT = "你是电影院购票系统的智能客服。请用简洁、准确、友好的中文回答。" +
            "你可以解释影片查询、场次查询、选座、购票、支付、订单和评论功能。" +
            "对于系统中没有提供的数据，不要编造，提醒用户到页面查看最新信息。" +
            "不要要求用户提供密码、支付密码或银行卡信息。当前只能提供咨询，不能替用户修改订单或执行支付。";

    private String apiUrl;
    private String apiKey;
    private String model;
    private final MovieService movieService = new MovieService();
    private final ScheduleService scheduleService = new ScheduleService();

    @Override
    public void init() throws ServletException {
        Properties properties = new Properties();
        InputStream input = null;
        try {
            input = getClass().getClassLoader().getResourceAsStream("ai.properties");
            if (input != null) {
                properties.load(new InputStreamReader(input, StandardCharsets.UTF_8));
            }
        } catch (IOException e) {
            throw new ServletException("读取 AI 配置失败", e);
        } finally {
            if (input != null) {
                try {
                    input.close();
                } catch (IOException ignored) {
                    // ignore
                }
            }
        }
        apiUrl = getConfig("AI_API_URL", "ai.api.url", DEFAULT_URL, properties);
        apiKey = getConfig("AI_API_KEY", "ai.api.key", "", properties);
        if (isBlank(apiKey)) {
            apiKey = System.getenv("OPENAI_API_KEY");
        }
        model = getConfig("AI_MODEL", "ai.model", DEFAULT_MODEL, properties);
    }

    private String getConfig(String environmentName, String propertyName, String defaultValue,
                             Properties properties) {
        String value = System.getenv(environmentName);
        if (isBlank(value)) {
            value = System.getProperty(propertyName);
        }
        if (isBlank(value)) {
            value = properties.getProperty(propertyName);
        }
        return isBlank(value) ? defaultValue : value.trim();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json; charset=UTF-8");
        try {
            String message = readMessage(req);
            if (isBlank(message)) {
                writeError(resp, 400, "请输入咨询内容");
                return;
            }
            if (message.length() > MAX_MESSAGE_LENGTH) {
                writeError(resp, 400, "咨询内容不能超过" + MAX_MESSAGE_LENGTH + "个字符");
                return;
            }
            if (requiresApiKey() && isBlank(apiKey)) {
                writeError(resp, 500, "请先配置 AI_API_KEY，再启动项目");
                return;
            }
            Map<String, Object> result = new HashMap<String, Object>();
            result.put("code", 0);
            result.put("data", requestModel(message.trim()));
            resp.getWriter().write(JSON.toJSONString(result));
        } catch (Exception e) {
            e.printStackTrace();
            writeError(resp, 500, "AI客服暂时无法响应，请检查模型服务配置");
        }
    }

    private String readMessage(HttpServletRequest req) throws IOException {
        String contentType = req.getContentType();
        if (contentType != null && contentType.toLowerCase().contains("application/json")) {
            String body = readBody(req);
            if (isBlank(body)) {
                return "";
            }
            JSONObject json = JSON.parseObject(body);
            return json == null ? "" : json.getString("message");
        }
        return req.getParameter("message");
    }

    private String readBody(HttpServletRequest req) throws IOException {
        StringBuilder body = new StringBuilder();
        BufferedReader reader = req.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            body.append(line);
        }
        return body.toString();
    }

    private String requestModel(String userMessage) throws IOException {
        JSONObject payload = new JSONObject();
        payload.put("model", model);

        JSONArray messages = new JSONArray();
        JSONObject systemMessage = new JSONObject();
        systemMessage.put("role", "system");
        systemMessage.put("content", SYSTEM_PROMPT + buildLiveDataContext(userMessage));
        messages.add(systemMessage);

        JSONObject user = new JSONObject();
        user.put("role", "user");
        user.put("content", userMessage);
        messages.add(user);
        payload.put("messages", messages);

        HttpURLConnection connection = null;
        try {
            connection = (HttpURLConnection) new URL(apiUrl).openConnection();
            connection.setRequestMethod("POST");
            connection.setConnectTimeout(10000);
            connection.setReadTimeout(60000);
            connection.setDoOutput(true);
            connection.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            connection.setRequestProperty("Accept", "application/json");
            if (!isBlank(apiKey)) {
                connection.setRequestProperty("Authorization", "Bearer " + apiKey);
            }

            OutputStreamWriter writer = new OutputStreamWriter(connection.getOutputStream(), StandardCharsets.UTF_8);
            writer.write(JSON.toJSONString(payload));
            writer.flush();
            writer.close();

            int status = connection.getResponseCode();
            InputStream responseStream = status >= 200 && status < 300
                    ? connection.getInputStream() : connection.getErrorStream();
            String responseBody = readStream(responseStream);
            if (status < 200 || status >= 300) {
                throw new IOException("模型接口返回 HTTP " + status + ": " + responseBody);
            }
            return extractAnswer(responseBody);
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
    }

    private String readStream(InputStream stream) throws IOException {
        if (stream == null) {
            return "";
        }
        StringBuilder text = new StringBuilder();
        BufferedReader reader = new BufferedReader(new InputStreamReader(stream, StandardCharsets.UTF_8));
        String line;
        while ((line = reader.readLine()) != null) {
            text.append(line);
        }
        reader.close();
        return text.toString();
    }

    private String extractAnswer(String responseBody) throws IOException {
        JSONObject response = JSON.parseObject(responseBody);
        if (response == null) {
            throw new IOException("模型返回内容为空");
        }
        JSONArray choices = response.getJSONArray("choices");
        if (choices == null || choices.isEmpty()) {
            throw new IOException("模型没有返回回答");
        }
        JSONObject choice = choices.getJSONObject(0);
        JSONObject message = choice == null ? null : choice.getJSONObject("message");
        String content = message == null ? null : message.getString("content");
        if (isBlank(content)) {
            throw new IOException("模型返回回答为空");
        }
        return content.trim();
    }

    /**
     * 只在用户询问影片或场次时读取少量公开数据，避免把订单、用户等敏感数据传给模型。
     * 数据库暂时不可用时仍然允许模型回答购票流程问题。
     */
    private String buildLiveDataContext(String userMessage) {
        boolean movieQuestion = containsAny(userMessage, "电影", "影片", "上映", "评分", "推荐");
        boolean scheduleQuestion = containsAny(userMessage, "场次", "排片", "放映", "几点", "时间", "余票", "座位");
        if (!movieQuestion && !scheduleQuestion) {
            return "";
        }

        StringBuilder context = new StringBuilder();
        context.append("\n\n【系统实时数据（只读，仅供回答当前问题）】\n");
        boolean hasData = false;
        try {
            if (movieQuestion) {
                List<Movie> movies = movieService.findAllMovies(1);
                if (movies != null && !movies.isEmpty()) {
                    context.append("当前上映影片：\n");
                    int count = 0;
                    for (Movie movie : movies) {
                        if (movie == null || count >= MAX_MOVIES_IN_CONTEXT) {
                            break;
                        }
                        context.append("- ").append(safe(movie.getMovie_cn_name()));
                        if (!isBlank(movie.getMovie_type())) {
                            context.append("，类型：").append(movie.getMovie_type());
                        }
                        context.append("，评分：").append(movie.getMovie_score()).append("\n");
                        count++;
                    }
                    hasData = count > 0;
                }
            }

            if (scheduleQuestion) {
                List<Schedule> schedules = scheduleService.findAllScheduleByState(1, MAX_SCHEDULES_IN_CONTEXT, 1)
                        .getList();
                if (schedules != null && !schedules.isEmpty()) {
                    context.append("当前可售场次（仅展示部分）：\n");
                    int count = 0;
                    for (Schedule schedule : schedules) {
                        if (schedule == null || count >= MAX_SCHEDULES_IN_CONTEXT) {
                            break;
                        }
                        Movie movie = schedule.getSchedule_movie();
                        Hall hall = schedule.getSchedule_hall();
                        Cinema cinema = hall == null ? null : hall.getHall_cinema();
                        context.append("- 影片：").append(movie == null ? "未知影片" : safe(movie.getMovie_cn_name()));
                        context.append("，时间：").append(safe(schedule.getSchedule_startTime()));
                        context.append("，票价：").append(schedule.getSchedule_price()).append("元");
                        context.append("，余票：").append(schedule.getSchedule_remain());
                        if (cinema != null && !isBlank(cinema.getCinema_name())) {
                            context.append("，影院：").append(cinema.getCinema_name());
                        }
                        if (hall != null && !isBlank(hall.getHall_name())) {
                            context.append("，影厅：").append(hall.getHall_name());
                        }
                        context.append("\n");
                        count++;
                    }
                    hasData = hasData || count > 0;
                }
            }
        } catch (Exception e) {
            // 数据库配置或连接异常不应阻断普通客服问答。
            context.append("实时数据暂时不可用，请以页面显示为准。\n");
        }
        if (!hasData && context.indexOf("实时数据暂时不可用") < 0) {
            context.append("没有查到匹配的实时数据，请以页面显示为准。\n");
        }
        context.append("如果实时数据中没有答案，请明确说明没有查到，不要猜测。\n");
        return context.toString();
    }

    private boolean containsAny(String text, String... keywords) {
        if (text == null) {
            return false;
        }
        for (String keyword : keywords) {
            if (text.contains(keyword)) {
                return true;
            }
        }
        return false;
    }

    private String safe(String value) {
        return value == null ? "未填写" : value;
    }

    private boolean requiresApiKey() {
        return apiUrl != null && apiUrl.toLowerCase().startsWith("https://api.openai.com/");
    }

    private void writeError(HttpServletResponse resp, int code, String message) throws IOException {
        resp.setStatus(code);
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("code", code);
        result.put("msg", message);
        resp.getWriter().write(JSON.toJSONString(result));
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().length() == 0;
    }
}
