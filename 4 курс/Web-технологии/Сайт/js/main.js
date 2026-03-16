/**
 * main.js — главная страница: категории, популярные товары, корзина в шапке
 */

(function() {
  const categoriesGrid = document.getElementById('categoriesGrid');
  const featuredProducts = document.getElementById('featuredProducts');
  const headerCartCount = document.getElementById('headerCartCount');
  const burger = document.getElementById('burger');
  const nav = document.getElementById('nav');

  function updateCartCount() {
    if (!headerCartCount) return;
    const cart = getCart();
    const total = cart.reduce((sum, item) => sum + item.quantity, 0);
    headerCartCount.textContent = total;
  }

  function renderCategories(categories) {
    if (!categoriesGrid) return;
    categoriesGrid.innerHTML = categories.map(cat => `
      <a href="catalog.html?category=${encodeURIComponent(cat.id)}" class="category-card">
        <span class="category-card__img-wrap">
          <img class="category-card__img" src="${escapeHtml(cat.image || '')}" alt="${escapeHtml(cat.name)}" loading="lazy">
        </span>
        <span class="category-card__name">${escapeHtml(cat.name)}</span>
      </a>
    `).join('');
  }

  function renderProductCard(product, categoryName) {
    const priceHtml = product.oldPrice
      ? `<span class="product-card__price">${formatPrice(product.price)}</span><span class="product-card__old-price">${formatPrice(product.oldPrice)}</span>`
      : `<span class="product-card__price">${formatPrice(product.price)}</span>`;
    const badge = product.bestseller ? '<span class="product-card__badge">Хит</span>' : '';
    return `
      <article class="product-card" style="position: relative;">
        ${badge}
        <a href="product.html?id=${encodeURIComponent(product.id)}" class="product-card__img-wrap">
          <img class="product-card__img" src="${escapeHtml(product.image || '')}" alt="${escapeHtml(product.name)}" loading="lazy">
        </a>
        <div class="product-card__body">
          <p class="product-card__category">${escapeHtml(categoryName || product.category)}</p>
          <h2 class="product-card__title"><a href="product.html?id=${encodeURIComponent(product.id)}">${escapeHtml(product.name)}</a></h2>
          <div class="product-card__prices">${priceHtml}</div>
          <div class="product-card__actions">
            <a href="product.html?id=${encodeURIComponent(product.id)}" class="btn btn--outline">Подробнее</a>
            <button type="button" class="btn btn--primary btn-add-cart" data-id="${escapeHtml(product.id)}">В корзину</button>
          </div>
        </div>
      </article>
    `;
  }

  function renderFeatured(products, categories) {
    if (!featuredProducts) return;
    const getCategoryName = (id) => (categories.find(c => c.id === id) || {}).name || id;
    const featured = products.filter(p => p.bestseller).slice(0, 8);
    const toShow = featured.length >= 4 ? featured : products.slice(0, 8);
    featuredProducts.innerHTML = toShow.map(p => renderProductCard(p, getCategoryName(p.category))).join('');

    featuredProducts.querySelectorAll('.btn-add-cart').forEach(btn => {
      btn.addEventListener('click', function(e) {
        e.preventDefault();
        const id = this.getAttribute('data-id');
        addToCart(id, 1);
        updateCartCount();
        showToast('Товар добавлен в корзину', 'success');
      });
    });
  }

  async function init() {
    updateCartCount();
    try {
      const [categories, products] = await Promise.all([loadCategories(), loadProducts()]);
      renderCategories(categories);
      renderFeatured(products, categories);
    } catch (err) {
      console.error(err);
      if (categoriesGrid) categoriesGrid.innerHTML = '<p>Не удалось загрузить категории.</p>';
      if (featuredProducts) featuredProducts.innerHTML = '<p>Не удалось загрузить товары.</p>';
    }
  }

  if (burger && nav) {
    burger.addEventListener('click', function() {
      nav.classList.toggle('nav--open');
    });
  }

  init();
})();
