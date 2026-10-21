(function () {
    "use strict";

    function initAiChat() {
        var toggle = document.getElementById("aiChatToggle");
        var panel = document.getElementById("aiChatPanel");
        var close = document.getElementById("aiChatClose");
        var form = document.getElementById("aiChatForm");
        var input = document.getElementById("aiChatInput");
        var send = document.getElementById("aiChatSend");
        var messages = document.getElementById("aiChatMessages");
        if (!toggle || !panel || !form || !input || !send || !messages) { return; }

        var endpoint = window.AI_CHAT_URL || "../ai/chat";

        function appendMessage(text, role) {
            var item = document.createElement("div");
            item.className = "ai-chat-message " + role;
            item.textContent = text;
            messages.appendChild(item);
            messages.scrollTop = messages.scrollHeight;
        }

        function setOpen(open) {
            panel.hidden = !open;
            toggle.setAttribute("aria-expanded", open ? "true" : "false");
            if (open) { input.focus(); }
        }

        toggle.addEventListener("click", function () { setOpen(panel.hidden); });
        if (close) { close.addEventListener("click", function () { setOpen(false); }); }

        form.addEventListener("submit", function (event) {
            event.preventDefault();
            var text = input.value.trim();
            if (!text || send.disabled) { return; }
            appendMessage(text, "user");
            input.value = "";
            send.disabled = true;
            appendMessage("正在查询，请稍候…", "bot ai-chat-loading");

            fetch(endpoint, {
                method: "POST",
                headers: {"Content-Type": "application/json;charset=UTF-8"},
                body: JSON.stringify({message: text})
            }).then(function (response) {
                return response.json();
            }).then(function (result) {
                var loading = messages.querySelector(".ai-chat-loading");
                if (loading) { loading.remove(); }
                if (result && result.code === 0 && result.data) {
                    appendMessage(result.data, "bot");
                } else {
                    appendMessage((result && result.msg) || "AI客服暂时无法响应，请检查模型服务配置。", "error");
                }
            }).catch(function () {
                var loading = messages.querySelector(".ai-chat-loading");
                if (loading) { loading.remove(); }
                appendMessage("AI客服暂时无法连接，请检查模型服务是否已启动。", "error");
            }).then(function () {
                send.disabled = false;
                input.focus();
            });
        });
    }

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", initAiChat);
    } else {
        initAiChat();
    }
}());
