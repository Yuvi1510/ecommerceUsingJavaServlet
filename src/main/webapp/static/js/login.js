document.addEventListener("DOMContentLoaded", () => {
    const container = document.querySelector('.container');
    const switchToRegister = document.querySelector('.switch-to-register');
    const switchToLogin = document.querySelector('.switch-to-login');

    // Selecting the forms
    const loginForm = document.querySelector('.login form');
    const registerForm = document.querySelector('.register form');

    // Select the buttons
    const loginBtn = document.querySelector('.login .btn');
    const registerBtn = document.querySelector('.register .btn');

    // toggling the login and registratiin
    if (switchToRegister) {
        switchToRegister.addEventListener('click', () => {
            container.classList.add('active');
        });
    }

    if (switchToLogin) {
        switchToLogin.addEventListener('click', () => {
            container.classList.remove('active');
        });
    }

    //Validation Logic
    const handleValidation = (form) => {
        //checking required attributes
        if (form.checkValidity()) {
            alert("Success! Form is complete.");

        } else {
            form.reportValidity();
        }
    };

    // adding event listner
    if (loginBtn) {
        loginBtn.addEventListener('click', (e) => {
            e.preventDefault();
            handleValidation(loginForm);
        });
    }

    if (registerBtn) {
        registerBtn.addEventListener('click', (e) => {
            e.preventDefault();
            handleValidation(registerForm);
        });
    }
});