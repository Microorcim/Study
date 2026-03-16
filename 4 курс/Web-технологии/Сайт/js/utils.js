/**
 * utils.js — вспомогательные функции
 * Учебный проект: интернет-магазин спортивных товаров
 */

/**
 * Форматирование цены в рублях
 * @param {number} price
 * @returns {string}
 */
function formatPrice(price) {
  return new Intl.NumberFormat('ru-RU', {
    style: 'currency',
    currency: 'RUB',
    maximumFractionDigits: 0
  }).format(price);
}

/**
 * Получить параметр из query string
 * @param {string} name
 * @returns {string|null}
 */
function getQueryParam(name) {
  const params = new URLSearchParams(window.location.search);
  return params.get(name);
}

/**
 * Показать уведомление (тост)
 * @param {string} message
 * @param {string} type — 'success' | 'error' | 'info'
 */
function showToast(message, type = 'success') {
  const existing = document.querySelector('.toast');
  if (existing) existing.remove();

  const toast = document.createElement('div');
  toast.className = `toast toast--${type}`;
  toast.textContent = message;
  document.body.appendChild(toast);

  requestAnimationFrame(() => toast.classList.add('toast--visible'));
  setTimeout(() => {
    toast.classList.remove('toast--visible');
    setTimeout(() => toast.remove(), 300);
  }, 3000);
}

/**
 * Генерация уникального ID (для новых товаров в админке)
 * @returns {string}
 */
function generateId() {
  return Date.now().toString(36) + Math.random().toString(36).slice(2);
}

/**
 * Экранирование HTML (простая защита от XSS в учебном проекте)
 * @param {string} str
 * @returns {string}
 */
function escapeHtml(str) {
  if (!str) return '';
  const div = document.createElement('div');
  div.textContent = str;
  return div.innerHTML;
}
