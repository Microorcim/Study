/**
 * storage.js — работа с localStorage и загрузка данных из JSON
 * Учебный проект: интернет-магазин спортивных товаров
 */

const STORAGE_KEYS = {
  CART: 'sportshop_cart',
  ORDERS: 'sportshop_orders',
  PRODUCTS: 'sportshop_products',
  ADMIN_AUTH: 'sportshop_admin_auth'
};

/**
 * Загружает JSON-файл по URL (для статического фронтенда)
 * @param {string} url — путь к JSON
 * @returns {Promise<Array|Object>}
 */
async function loadJSON(url) {
  const response = await fetch(url);
  if (!response.ok) throw new Error(`Ошибка загрузки: ${url}`);
  return response.json();
}

/**
 * Загружает категории из data/categories.json
 */
async function loadCategories() {
  return loadJSON('data/categories.json');
}

/**
 * Загружает товары: сначала проверяет localStorage (изменения админа),
 * если нет — загружает из data/products.json
 */
async function loadProducts() {
  const stored = localStorage.getItem(STORAGE_KEYS.PRODUCTS);
  if (stored) {
    try {
      return JSON.parse(stored);
    } catch (e) {
      console.warn('Ошибка парсинга сохраненных товаров, загружаем из JSON');
    }
  }
  return loadJSON('data/products.json');
}

/**
 * Сохраняет массив товаров в localStorage (после добавления/редактирования/удаления в админке)
 * @param {Array} products
 */
function saveProducts(products) {
  localStorage.setItem(STORAGE_KEYS.PRODUCTS, JSON.stringify(products));
}

/**
 * Корзина: получить из localStorage
 * @returns {Array<{id: string, quantity: number}>}
 */
function getCart() {
  const raw = localStorage.getItem(STORAGE_KEYS.CART);
  if (!raw) return [];
  try {
    return JSON.parse(raw);
  } catch (e) {
    return [];
  }
}

/**
 * Корзина: сохранить в localStorage
 * @param {Array} cart
 */
function setCart(cart) {
  localStorage.setItem(STORAGE_KEYS.CART, JSON.stringify(cart));
}

/**
 * Добавить товар в корзину или увеличить количество
 * @param {string} productId
 * @param {number} quantity
 */
function addToCart(productId, quantity = 1) {
  const cart = getCart();
  const item = cart.find(i => i.id === productId);
  if (item) item.quantity += quantity;
  else cart.push({ id: productId, quantity });
  setCart(cart);
}

/**
 * Установить количество товара в корзине
 * @param {string} productId
 * @param {number} quantity — если 0, товар удаляется
 */
function setCartItemQuantity(productId, quantity) {
  let cart = getCart();
  if (quantity <= 0) {
    cart = cart.filter(i => i.id !== productId);
  } else {
    const item = cart.find(i => i.id === productId);
    if (item) item.quantity = quantity;
    else cart.push({ id: productId, quantity });
  }
  setCart(cart);
}

/**
 * Удалить товар из корзины
 * @param {string} productId
 */
function removeFromCart(productId) {
  setCartItemQuantity(productId, 0);
}

/**
 * Очистить корзину
 */
function clearCart() {
  setCart([]);
}

/**
 * Заказы: получить все заказы из localStorage
 * @returns {Array}
 */
function getOrders() {
  const raw = localStorage.getItem(STORAGE_KEYS.ORDERS);
  if (!raw) return [];
  try {
    return JSON.parse(raw);
  } catch (e) {
    return [];
  }
}

/**
 * Заказы: сохранить массив заказов
 * @param {Array} orders
 */
function setOrders(orders) {
  localStorage.setItem(STORAGE_KEYS.ORDERS, JSON.stringify(orders));
}

/**
 * Добавить новый заказ
 * @param {Object} order — { items, total, customer: { fio, phone, email, address, comment }, status }
 * @returns {string} id заказа
 */
function addOrder(order) {
  const orders = getOrders();
  const id = 'ORD-' + Date.now();
  orders.unshift({
    id,
    ...order,
    status: order.status || 'новый',
    createdAt: new Date().toISOString()
  });
  setOrders(orders);
  return id;
}

/**
 * Обновить статус заказа (для админки)
 * @param {string} orderId
 * @param {string} status
 */
function updateOrderStatus(orderId, status) {
  const orders = getOrders();
  const order = orders.find(o => o.id === orderId);
  if (order) {
    order.status = status;
    setOrders(orders);
  }
}

/**
 * Проверка авторизации админа (учебная имитация)
 * @returns {boolean}
 */
function isAdminLoggedIn() {
  return localStorage.getItem(STORAGE_KEYS.ADMIN_AUTH) === '1';
}

/**
 * Установить флаг входа админа (учебная имитация — не для production!)
 * @param {boolean} value
 */
function setAdminAuth(value) {
  if (value) localStorage.setItem(STORAGE_KEYS.ADMIN_AUTH, '1');
  else localStorage.removeItem(STORAGE_KEYS.ADMIN_AUTH);
}
