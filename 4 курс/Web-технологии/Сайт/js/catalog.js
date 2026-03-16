/**
 * catalog.js — каталог: загрузка товаров, фильтры, поиск, сортировка, рендер карточек
 */

(function() {
  const searchInput = document.getElementById('searchInput');
  const filterCategory = document.getElementById('filterCategory');
  const priceMin = document.getElementById('priceMin');
  const priceMax = document.getElementById('priceMax');
  const sortSelect = document.getElementById('sortSelect');
  const resetFilters = document.getElementById('resetFilters');
  const catalogProducts = document.getElementById('catalogProducts');
  const catalogResults = document.getElementById('catalogResults');
  const catalogEmpty = document.getElementById('catalogEmpty');
  const headerCartCount = document.getElementById('headerCartCount');
  const burger = document.getElementById('burger');
  const nav = document.getElementById('nav');

  let allProducts = [];
  let categories = [];

  function updateCartCount() {
    if (!headerCartCount) return;
    const cart = getCart();
    headerCartCount.textContent = cart.reduce((s, i) => s + i.quantity, 0);
  }

  function getCategoryName(id) {
    return (categories.find(c => c.id === id) || {}).name || id;
  }

  function renderCard(product) {
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
          <p class="product-card__category">${escapeHtml(getCategoryName(product.category))}</p>
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

  function applyFilters() {
    let list = [...allProducts];
    const query = (searchInput && searchInput.value.trim()) || '';
    const categoryId = filterCategory && filterCategory.value;
    const min = priceMin && priceMin.value ? Number(priceMin.value) : null;
    const max = priceMax && priceMax.value ? Number(priceMax.value) : null;
    const sort = sortSelect && sortSelect.value ? sortSelect.value : 'default';

    if (query) {
      const q = query.toLowerCase();
      list = list.filter(p => (p.name || '').toLowerCase().includes(q) || (p.brand || '').toLowerCase().includes(q));
    }
    if (categoryId) list = list.filter(p => p.category === categoryId);
    if (min != null && !isNaN(min)) list = list.filter(p => p.price >= min);
    if (max != null && !isNaN(max)) list = list.filter(p => p.price <= max);

    if (sort === 'price-asc') list.sort((a, b) => a.price - b.price);
    else if (sort === 'price-desc') list.sort((a, b) => b.price - a.price);
    else if (sort === 'name-asc') list.sort((a, b) => (a.name || '').localeCompare(b.name || ''));
    else if (sort === 'name-desc') list.sort((a, b) => (b.name || '').localeCompare(a.name || ''));

    return list;
  }

  function render() {
    const list = applyFilters();
    if (catalogResults) catalogResults.textContent = `Найдено: ${list.length}`;
    if (catalogEmpty) {
      catalogEmpty.classList.toggle('hidden', list.length > 0);
    }
    if (catalogProducts) {
      catalogProducts.classList.toggle('hidden', list.length === 0);
      catalogProducts.innerHTML = list.map(renderCard).join('');
      catalogProducts.querySelectorAll('.btn-add-cart').forEach(btn => {
        btn.addEventListener('click', function(e) {
          e.preventDefault();
          const id = this.getAttribute('data-id');
          addToCart(id, 1);
          updateCartCount();
          showToast('Товар добавлен в корзину', 'success');
        });
      });
    }
  }

  function fillCategoryFilter() {
    if (!filterCategory) return;
    const current = filterCategory.innerHTML;
    if (filterCategory.options.length > 1) return;
    categories.forEach(c => {
      const opt = document.createElement('option');
      opt.value = c.id;
      opt.textContent = c.name;
      filterCategory.appendChild(opt);
    });
    const urlCategory = getQueryParam('category');
    if (urlCategory) filterCategory.value = urlCategory;
  }

  async function init() {
    updateCartCount();
    try {
      [categories, allProducts] = await Promise.all([loadCategories(), loadProducts()]);
      fillCategoryFilter();
    } catch (e) {
      console.error(e);
      allProducts = [];
      categories = [];
    }
    render();

    if (searchInput) searchInput.addEventListener('input', render);
    if (filterCategory) filterCategory.addEventListener('change', render);
    if (priceMin) priceMin.addEventListener('input', render);
    if (priceMax) priceMax.addEventListener('input', render);
    if (sortSelect) sortSelect.addEventListener('change', render);
    if (resetFilters) {
      resetFilters.addEventListener('click', function() {
        if (searchInput) searchInput.value = '';
        if (filterCategory) filterCategory.value = '';
        if (priceMin) priceMin.value = '';
        if (priceMax) priceMax.value = '';
        if (sortSelect) sortSelect.value = 'default';
        render();
      });
    }
  }

  if (burger && nav) burger.addEventListener('click', () => nav.classList.toggle('nav--open'));
  init();
})();
