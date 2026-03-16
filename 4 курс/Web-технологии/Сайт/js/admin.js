/**
 * admin.js — админ-панель: товары (CRUD), заказы, статусы
 */

(function() {
  const adminProductsBody = document.getElementById('adminProductsBody');
  const adminOrdersBody = document.getElementById('adminOrdersBody');
  const adminOrdersEmpty = document.getElementById('adminOrdersEmpty');
  const adminProductSearch = document.getElementById('adminProductSearch');
  const adminCategoryFilter = document.getElementById('adminCategoryFilter');
  const adminAddProduct = document.getElementById('adminAddProduct');
  const adminLogout = document.getElementById('adminLogout');
  const productModal = document.getElementById('productModal');
  const productForm = document.getElementById('productForm');
  const productModalTitle = document.getElementById('productModalTitle');
  const productFormId = document.getElementById('productFormId');
  const productCategorySelect = document.getElementById('productCategory');

  let categories = [];
  let products = [];
  let orders = [];

  if (!isAdminLoggedIn()) {
    window.location.href = 'admin-login.html';
    return;
  }

  function renderProducts(filtered) {
    const list = filtered !== undefined ? filtered : products;
    const getCatName = id => (categories.find(c => c.id === id) || {}).name || id;
    if (!adminProductsBody) return;
    adminProductsBody.innerHTML = list.map(p => `
      <tr>
        <td>${escapeHtml(p.id)}</td>
        <td><img src="${escapeHtml(p.image || '')}" alt="" style="width:48px;height:48px;object-fit:cover;border-radius:6px;"></td>
        <td>${escapeHtml(p.name)}</td>
        <td>${escapeHtml(getCatName(p.category))}</td>
        <td>${formatPrice(p.price)}</td>
        <td>${p.inStock ? 'Да' : 'Нет'}</td>
        <td>
          <button type="button" class="btn btn--outline btn--sm btn-edit" data-id="${escapeHtml(p.id)}">Изменить</button>
          <button type="button" class="btn btn--outline btn--sm btn-delete" data-id="${escapeHtml(p.id)}">Удалить</button>
        </td>
      </tr>
    `).join('');

    adminProductsBody.querySelectorAll('.btn-edit').forEach(btn => {
      btn.addEventListener('click', () => openProductModal(btn.getAttribute('data-id')));
    });
    adminProductsBody.querySelectorAll('.btn-delete').forEach(btn => {
      btn.addEventListener('click', () => deleteProduct(btn.getAttribute('data-id')));
    });
  }

  function applyProductFilters() {
    const q = (adminProductSearch && adminProductSearch.value.trim().toLowerCase()) || '';
    const cat = (adminCategoryFilter && adminCategoryFilter.value) || '';
    let list = products;
    if (q) list = list.filter(p => (p.name || '').toLowerCase().includes(q));
    if (cat) list = list.filter(p => p.category === cat);
    renderProducts(list);
  }

  function renderOrders() {
    orders = getOrders();
    if (!adminOrdersBody) return;
    if (orders.length === 0) {
      adminOrdersBody.innerHTML = '';
      if (adminOrdersEmpty) adminOrdersEmpty.classList.remove('hidden');
      return;
    }
    if (adminOrdersEmpty) adminOrdersEmpty.classList.add('hidden');
    const statuses = ['новый', 'подтвержден', 'отправлен', 'завершен'];
    adminOrdersBody.innerHTML = orders.map(o => {
      const customer = o.customer || {};
      const statusSelect = `<select class="admin-order-status" data-order-id="${escapeHtml(o.id)}">${statuses.map(s => `<option value="${escapeHtml(s)}" ${o.status === s ? 'selected' : ''}>${escapeHtml(s)}</option>`).join('')}</select>`;
      return `
        <tr>
          <td>${escapeHtml(o.id)}</td>
          <td>${o.createdAt ? new Date(o.createdAt).toLocaleString('ru-RU') : '—'}</td>
          <td>${escapeHtml(customer.fio || '—')}<br><small>${escapeHtml(customer.phone || '')} ${escapeHtml(customer.email || '')}</small><br><small>${escapeHtml(customer.address || '')}</small></td>
          <td>${formatPrice(o.total || 0)}</td>
          <td>${statusSelect}</td>
          <td>—</td>
        </tr>
      `;
    }).join('');

    adminOrdersBody.querySelectorAll('.admin-order-status').forEach(sel => {
      sel.addEventListener('change', function() {
        updateOrderStatus(this.getAttribute('data-order-id'), this.value);
        renderOrders();
      });
    });
  }

  function fillCategoryOptions(select, selectedId) {
    if (!select) return;
    select.innerHTML = '<option value="">— Выберите —</option>' + categories.map(c => `<option value="${escapeHtml(c.id)}" ${c.id === selectedId ? 'selected' : ''}>${escapeHtml(c.name)}</option>`).join('');
  }

  function openProductModal(productId) {
    if (productModalTitle) productModalTitle.textContent = productId ? 'Редактировать товар' : 'Добавить товар';
    if (productFormId) productFormId.value = productId || '';
    const product = productId ? products.find(p => p.id === productId) : null;
    if (product) {
      if (document.getElementById('productName')) document.getElementById('productName').value = product.name || '';
      if (document.getElementById('productBrand')) document.getElementById('productBrand').value = product.brand || '';
      if (document.getElementById('productPrice')) document.getElementById('productPrice').value = product.price || '';
      if (document.getElementById('productImage')) document.getElementById('productImage').value = product.image || '';
      if (document.getElementById('productDesc')) document.getElementById('productDesc').value = product.description || '';
      if (document.getElementById('productInStock')) document.getElementById('productInStock').checked = product.inStock !== false;
      fillCategoryOptions(productCategorySelect, product.category);
    } else {
      if (productForm) productForm.reset();
      if (document.getElementById('productFormId')) document.getElementById('productFormId').value = '';
      fillCategoryOptions(productCategorySelect, '');
    }
    if (productModal) productModal.classList.remove('hidden');
  }

  function closeProductModal() {
    if (productModal) productModal.classList.add('hidden');
  }

  function deleteProduct(id) {
    if (!confirm('Удалить этот товар?')) return;
    products = products.filter(p => p.id !== id);
    saveProducts(products);
    renderProducts();
    closeProductModal();
    showToast('Товар удален', 'success');
  }

  document.querySelectorAll('[data-close="productModal"]').forEach(el => {
    el.addEventListener('click', closeProductModal);
  });

  if (productForm) {
    productForm.addEventListener('submit', function(e) {
      e.preventDefault();
      const id = productFormId && productFormId.value;
      const name = (document.getElementById('productName') && document.getElementById('productName').value.trim()) || '';
      const category = (productCategorySelect && productCategorySelect.value) || '';
      const price = parseInt(document.getElementById('productPrice') && document.getElementById('productPrice').value, 10);
      if (!name || !category || isNaN(price) || price < 0) {
        showToast('Заполните обязательные поля', 'error');
        return;
      }
      const base = id ? products.find(p => p.id === id) || {} : {};
      const product = {
        ...base,
        id: id || generateId(),
        name,
        category,
        brand: (document.getElementById('productBrand') && document.getElementById('productBrand').value.trim()) || '',
        price,
        image: (document.getElementById('productImage') && document.getElementById('productImage').value.trim()) || 'https://placehold.co/400x400/1a1a2e/eee?text=Product',
        description: (document.getElementById('productDesc') && document.getElementById('productDesc').value.trim()) || '',
        inStock: document.getElementById('productInStock') ? document.getElementById('productInStock').checked : true,
        bestseller: base.bestseller || false,
        rating: base.rating || 4,
        oldPrice: base.oldPrice,
        specs: base.specs || {}
      };
      if (id) {
        const idx = products.findIndex(p => p.id === id);
        if (idx >= 0) products[idx] = product;
        else products.push(product);
      } else {
        products.push(product);
      }
      saveProducts(products);
      renderProducts();
      closeProductModal();
      showToast(id ? 'Товар обновлен' : 'Товар добавлен', 'success');
    });
  }

  if (adminAddProduct) adminAddProduct.addEventListener('click', () => openProductModal(null));
  if (adminLogout) adminLogout.addEventListener('click', () => { setAdminAuth(false); window.location.href = 'admin-login.html'; });

  document.querySelectorAll('.admin-tabs__btn').forEach(btn => {
    btn.addEventListener('click', function() {
      const tab = this.getAttribute('data-tab');
      document.querySelectorAll('.admin-tabs__btn').forEach(b => b.classList.remove('active'));
      document.querySelectorAll('.admin-section').forEach(s => s.classList.remove('active'));
      this.classList.add('active');
      const section = document.getElementById('section-' + tab);
      if (section) section.classList.add('active');
      if (tab === 'orders') renderOrders();
    });
  });

  if (adminProductSearch) adminProductSearch.addEventListener('input', applyProductFilters);
  if (adminCategoryFilter) adminCategoryFilter.addEventListener('change', applyProductFilters);

  async function init() {
    try {
      categories = await loadCategories();
      products = await loadProducts();
    } catch (e) {
      categories = [];
      products = [];
    }
    fillCategoryOptions(adminCategoryFilter, '');
    fillCategoryOptions(productCategorySelect, '');
    renderProducts();
    renderOrders();
  }

  init();
})();
