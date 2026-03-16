/**
 * admin-login.js — учебная имитация авторизации администратора
 * ВНИМАНИЕ: это не безопасная реализация, только для учебного проекта.
 * В production необходима серверная аутентификация.
 */

(function() {
  const ADMIN_LOGIN = 'admin';
  const ADMIN_PASSWORD = 'admin123';

  const form = document.getElementById('adminLoginForm');
  const loginInput = document.getElementById('adminLogin');
  const passwordInput = document.getElementById('adminPassword');
  const errorEl = document.getElementById('adminLoginError');

  if (isAdminLoggedIn()) {
    window.location.href = 'admin.html';
    return;
  }

  if (form) {
    form.addEventListener('submit', function(e) {
      e.preventDefault();
      const login = (loginInput && loginInput.value) || '';
      const password = (passwordInput && passwordInput.value) || '';

      if (errorEl) errorEl.textContent = '';

      if (login === ADMIN_LOGIN && password === ADMIN_PASSWORD) {
        setAdminAuth(true);
        window.location.href = 'admin.html';
      } else {
        if (errorEl) errorEl.textContent = 'Неверный логин или пароль.';
      }
    });
  }
})();
