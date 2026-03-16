/**
 * product.js — страница товара: загрузка по id, похожие товары, добавление в корзину
 */

(function() {
  const id = getQueryParam('id');
  const productDetail = document.getElementById('productDetail');
  const productImage = document.getElementById('productImage');
  const productCategory = document.getElementById('productCategory');
  const productTitle = document.getElementById('productTitle');
  const productBrand = document.getElementById('productBrand');
  const productPrice = document.getElementById('productPrice');
  const productOldPrice = document.getElementById('productOldPrice');
  const productStock = document.getElementById('productStock');
  const productDesc = document.getElementById('productDesc');
  const productSpecs = document.getElementById('productSpecs');
  const productQty = document.getElementById('productQty');
  const addToCartBtn = document.getElementById('addToCartBtn');
  const breadcrumbProduct = document.getElementById('breadcrumbProduct');
  const relatedProducts = document.getElementById('relatedProducts');
  const headerCartCount = document.getElementById('headerCartCount');
  const burger = document.getElementById('burger');
  const nav = document.getElementById('nav');

  let categories = [];
  let products = [];
  let currentProduct = null;

  function updateCartCount() {
    if (headerCartCount) headerCartCount.textContent = getCart().reduce((s, i) => s + i.quantity, 0);
  }

  function getCategoryName(catId) {
    return (categories.find(c => c.id === catId) || {}).name || catId;
  }

  function renderSpecs(specs) {
    if (!specs || typeof specs !== 'object') return '';
    return Object.entries(specs).map(([k, v]) => `<dt>${escapeHtml(k)}</dt><dd>${escapeHtml(String(v))}</dd>`).join('');
  }

  function renderProduct(data) {
    if (!data) return;
    currentProduct = data;
    if (productImage) {
      productImage.src = data.image || '';
      productImage.alt = data.name || '';
    }
    if (productCategory) productCategory.textContent = getCategoryName(data.category);
    if (productTitle) productTitle.textContent = data.name || '';
    if (productBrand) productBrand.textContent = data.brand ? `Бренд: ${data.brand}` : '';
    if (productPrice) productPrice.textContent = formatPrice(data.price);
    if (productOldPrice) {
      productOldPrice.textContent = data.oldPrice ? formatPrice(data.oldPrice) : '';
      productOldPrice.style.display = data.oldPrice ? '' : 'none';
    }
    if (productStock) {
      productStock.textContent = data.inStock ? 'В наличии' : 'Нет в наличии';
      productStock.className = 'product-detail__stock ' + (data.inStock ? 'in-stock' : 'out-of-stock');
    }
    if (productDesc) productDesc.textContent = data.description || '';
    if (productSpecs) productSpecs.innerHTML = renderSpecs(data.specs);
    if (breadcrumbProduct) breadcrumbProduct.textContent = data.name || 'Товар';
    if (addToCartBtn) {
      addToCartBtn.disabled = !data.inStock;
      addToCartBtn.textContent = data.inStock ? 'Добавить в корзину' : 'Нет в наличии';
    }
  }

  function renderRelated(excludeId, categoryId, limit) {
    const related = products.filter(p => p.id !== excludeId && p.category === categoryId).slice(0, limit);
    if (!relatedProducts) return;
    if (related.length === 0) {
      relatedProducts.innerHTML = '<p>Нет похожих товаров.</p>';
      return;
    }
    const priceHtml = p => p.oldPrice
      ? `<span class="product-card__price">${formatPrice(p.price)}</span><span class="product-card__old-price">${formatPrice(p.oldPrice)}</span>`
      : `<span class="product-card__price">${formatPrice(p.price)}</span>`;
    relatedProducts.innerHTML = related.map(p => `
      <article class="product-card">
        <a href="product.html?id=${encodeURIComponent(p.id)}" class="product-card__img-wrap">
          <img class="product-card__img" src="${escapeHtml(p.image || '')}" alt="${escapeHtml(p.name)}" loading="lazy">
        </a>
        <div class="product-card__body">
          <p class="product-card__category">${escapeHtml(getCategoryName(p.category))}</p>
          <h2 class="product-card__title"><a href="product.html?id=${encodeURIComponent(p.id)}">${escapeHtml(p.name)}</a></h2>
          <div class="product-card__prices">${priceHtml(p)}</div>
          <div class="product-card__actions">
            <a href="product.html?id=${encodeURIComponent(p.id)}" class="btn btn--outline">Подробнее</a>
            <button type="button" class="btn btn--primary btn-add-cart" data-id="${escapeHtml(p.id)}">В корзину</button>
          </div>
        </div>
      </article>
    `).join('');
    relatedProducts.querySelectorAll('.btn-add-cart').forEach(btn => {
      btn.addEventListener('click', function(e) {
        e.preventDefault();
        addToCart(this.getAttribute('data-id'), 1);
        updateCartCount();
        showToast('Товар добавлен в корзину', 'success');
      });
    });
  }

  async function init() {
    updateCartCount();
    if (!id) {
      if (productDetail) productDetail.innerHTML = '<p>Товар не найден.</p>';
      return;
    }
    try {
      [categories, products] = await Promise.all([loadCategories(), loadProducts()]);
      const product = products.find(p => p.id === id);
      if (!product) {
        if (productDetail) productDetail.innerHTML = '<p>Товар не найден.</p>';
        return;
      }
      renderProduct(product);
      renderRelated(product.id, product.category, 4);
    } catch (e) {
      console.error(e);
      if (productDetail) productDetail.innerHTML = '<p>Ошибка загрузки.</p>';
    }
  }

  if (addToCartBtn) {
    addToCartBtn.addEventListener('click', function() {
      if (!currentProduct || !currentProduct.inStock) return;
      const qty = parseInt(productQty && productQty.value, 10) || 1;
      addToCart(currentProduct.id, qty);
      updateCartCount();
      showToast('Товар добавлен в корзину', 'success');
    });
  }

  if (burger && nav) burger.addEventListener('click', () => nav.classList.toggle('nav--open'));
  init();
})();
