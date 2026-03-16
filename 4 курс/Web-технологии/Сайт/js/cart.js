/**
 * cart.js — корзина: список товаров, изменение количества, удаление, итого
 */

(function() {
  const cartList = document.getElementById('cartList');
  const cartTotal = document.getElementById('cartTotal');
  const cartEmpty = document.getElementById('cartEmpty');
  const cartContent = document.getElementById('cartContent');
  const headerCartCount = document.getElementById('headerCartCount');
  const burger = document.getElementById('burger');
  const nav = document.getElementById('nav');

  function updateCartCount() {
    if (headerCartCount) headerCartCount.textContent = getCart().reduce((s, i) => s + i.quantity, 0);
  }

  function getProductById(id) {
    return window.__cartProducts ? window.__cartProducts.find(p => p.id === id) : null;
  }

  function render() {
    const cart = getCart();
    if (cart.length === 0) {
      if (cartEmpty) cartEmpty.classList.remove('hidden');
      if (cartContent) cartContent.classList.add('hidden');
      return;
    }
    if (cartEmpty) cartEmpty.classList.add('hidden');
    if (cartContent) cartContent.classList.remove('hidden');

    let totalSum = 0;
    const rows = cart.map(item => {
      const product = getProductById(item.id);
      if (!product) return '';
      const sum = product.price * item.quantity;
      totalSum += sum;
      return `
        <div class="cart-item" data-id="${escapeHtml(item.id)}">
          <img class="cart-item__img" src="${escapeHtml(product.image || '')}" alt="">
          <div class="cart-item__info">
            <h3 class="cart-item__title"><a href="product.html?id=${encodeURIComponent(product.id)}">${escapeHtml(product.name)}</a></h3>
            <p class="cart-item__price">${formatPrice(product.price)} × ${item.quantity} = ${formatPrice(sum)}</p>
          </div>
          <div class="cart-item__qty">
            <label class="visually-hidden">Количество</label>
            <input type="number" class="input cart-qty-input" value="${item.quantity}" min="1" max="99" data-id="${escapeHtml(item.id)}">
          </div>
          <button type="button" class="cart-item__remove cart-remove" data-id="${escapeHtml(item.id)}">Удалить</button>
        </div>
      `;
    }).filter(Boolean).join('');

    if (cartList) cartList.innerHTML = rows;
    if (cartTotal) cartTotal.textContent = formatPrice(totalSum);

    cartList.querySelectorAll('.cart-qty-input').forEach(input => {
      input.addEventListener('change', function() {
        const id = this.getAttribute('data-id');
        let val = parseInt(this.value, 10);
        if (isNaN(val) || val < 1) val = 1;
        if (val > 99) val = 99;
        setCartItemQuantity(id, val);
        this.value = val;
        render();
        updateCartCount();
      });
    });
    cartList.querySelectorAll('.cart-remove').forEach(btn => {
      btn.addEventListener('click', function() {
        removeFromCart(this.getAttribute('data-id'));
        render();
        updateCartCount();
        showToast('Товар удален из корзины', 'info');
      });
    });
  }

  async function init() {
    updateCartCount();
    try {
      const products = await loadProducts();
      window.__cartProducts = products;
    } catch (e) {
      window.__cartProducts = [];
    }
    render();
  }

  if (burger && nav) burger.addEventListener('click', () => nav.classList.toggle('nav--open'));
  init();
})();
