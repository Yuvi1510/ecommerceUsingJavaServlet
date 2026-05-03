document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("support-form");
    const feedback = document.getElementById("form-feedback");
    const MIN_MESSAGE = 10;

    const hideFeedback = () => {
        if (!feedback) return;
        feedback.hidden = true;
        feedback.textContent = "";
        feedback.classList.remove("success", "error");
    };

    const showFeedback = (message, type) => {
        if (!feedback) return;
        feedback.textContent = message;
        feedback.classList.remove("success", "error");
        feedback.classList.add(type === "error" ? "error" : "success");
        feedback.hidden = false;
    };

    if (form && feedback) {
        form.addEventListener("submit", (e) => {
            e.preventDefault();

            const message = form.querySelector("#support-message");
            const trimmed = message ? message.value.trim() : "";

            if (!form.checkValidity()) {
                form.reportValidity();
                return;
            }

            if (trimmed.length < MIN_MESSAGE) {
                showFeedback(`Please enter at least ${MIN_MESSAGE} characters in your message.`, "error");
                if (message) message.focus();
                return;
            }

            showFeedback(
                "Thanks — your message has been noted. We will email you soon. (Demo: no data was sent to a server.)",
                "success"
            );
            form.reset();
        });

        const clearFeedbackOnEdit = () => {
            if (!feedback.hidden) hideFeedback();
        };
        form.addEventListener("input", clearFeedbackOnEdit);
        form.addEventListener("change", clearFeedbackOnEdit);
    }

    const faqItems = document.querySelectorAll(".faq-block .faq-item");
    faqItems.forEach((item) => {
        item.addEventListener("toggle", () => {
            if (!item.open) return;
            faqItems.forEach((other) => {
                if (other !== item) other.open = false;
            });
        });
    });
});
