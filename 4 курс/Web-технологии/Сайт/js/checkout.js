/**
 * checkout.js — оформление заказа: форма, валидация, сохранение заказа, редирект на success
 */

(function() {
  const form = document.getElementById('checkoutForm');
  const checkoutEmpty = document.getElementById('checkoutEmpty');
  const checkoutLayout = document.getElementById('checkoutLayout');
  const checkoutSummaryList = document.getElementById('checkoutSummaryList');
  const checkoutTotal = document.getElementById('checkoutTotal');
  const headerCartCount = document.getElementById('headerCartCount');
  const burger = document.getElementById('burger');
  const nav = document.getElementById('nav');

  const fields = {
    fio: { el: document.getElementById('fio'), error: document.getElementById('errorFio') },
    phone: { el: document.getElementById('phone'), error: document.getElementById('errorPhone') },
    email: { el: document.getElementById('email'), error: document.getElementById('errorEmail') },
    address: { el: document.getElementById('address'), error: document.getElementById('errorAddress') }
  };

  function updateCartCount() {
    if (headerCartCount) headerCartCount.textContent = getCart().reduce((s, i) => s + i.quantity, 0);
  }

  function validateFio(value) {
    const v = (value || '').trim();
    return v.length >= 2 && v.split(/\s+/).length >= 2;
  }

  function validatePhone(value) {
    const digits = (value || '').replace(/\D/g, '');
    return digits.length >= 10;
  }

  function validateEmail(value) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test((value || '').trim());
  }

  function validateAddress(value) {
    return (value || '').trim().length >= 10;
  }

  function showError(name, message) {
    const f = fields[name];
    if (f && f.error) f.error.textContent = message || '';
  }

  function validate() {
    let valid = true;
    const v = {};
    v.fio = fields.fio.el ? fields.fio.el.value.trim() : '';
    v.phone = fields.phone.el ? fields.phone.el.value : '';
    v.email = fields.email.el ? fields.email.el.value.trim() : '';
    v.address = fields.address.el ? fields.address.el.value.trim() : '';

    if (!validateFio(v.fio)) {
      showError('fio', 'Введите ФИО (минимум 2 слова)');
      valid = false;
    } else showError('fio');

    if (!validatePhone(v.phone)) {
      showError('phone', 'Введите корректный номер телефона');
      valid = false;
    } else showError('phone');

    if (!validateEmail(v.email)) {
      showError('email', 'Введите корректный email');
      valid = false;
    } else showError('email');

    if (!validateAddress(v.address)) {
      showError('address', 'Введите адрес доставки (не менее 10 символов)');
      valid = false;
    } else showError('address');

    return valid;
  }

  function renderSummary(products) {
    const cart = getCart();
    if (!checkoutSummaryList || !checkoutTotal) return;
    let total = 0;
    const items = cart.map(item => {
      const p = products.find(x => x.id === item.id);
      if (!p) return null;
      const sum = p.price * item.quantity;
      total += sum;
      return `<div class="checkout-summary__item"><span>${escapeHtml(p.name)} × ${item.quantity}</span><span>${formatPrice(sum)}</span></div>`;
    }).filter(Boolean).join('');
    checkoutSummaryList.innerHTML = items;
    checkoutTotal.textContent = formatPrice(total);
  }

  async function init() {
    updateCartCount();
    const cart = getCart();
    if (cart.length === 0) {
      if (checkoutEmpty) checkoutEmpty.classList.remove('hidden');
      if (checkoutLayout) checkoutLayout.classList.add('hidden');
      return;
    }
    if (checkoutEmpty) checkoutEmpty.classList.add('hidden');
    if (checkoutLayout) checkoutLayout.classList.remove('hidden');
    try {
      const products = await loadProducts();
      renderSummary(products);
    } catch (e) {
      renderSummary([]);
    }
  }

  if (form) {
    form.addEventListener('submit', async function(e) {
      e.preventDefault();
      if (!validate()) {
        showToast('Заполните обязательные поля корректно', 'error');
        return;
      }
      const cart = getCart();
      let products = [];
      try {
        products = await loadProducts();
      } catch (err) {}
      let totalSum = 0;
      const items = cart.map(item => {
        const p = products.find(x => x.id === item.id);
        if (!p) return null;
        totalSum += p.price * item.quantity;
        return { id: p.id, name: p.name, price: p.price, quantity: item.quantity };
      }).filter(Boolean);

      const order = {
        items,
        total: totalSum,
        customer: {
          fio: fields.fio.el.value.trim(),
          phone: fields.phone.el.value.trim(),
          email: fields.email.el.value.trim(),
          address: fields.address.el.value.trim(),
          comment: (document.getElementById('comment') && document.getElementById('comment').value) || ''
        },
        status: 'новый'
      };
      const orderId = addOrder(order);
      clearCart();
      window.location.href = 'success.html?order=' + encodeURIComponent(orderId) + '&total=' + encodeURIComponent(formatPrice(totalSum));
    });
  }

  if (burger && nav) burger.addEventListener('click', () => nav.classList.toggle('nav--open'));
  init();
})();
