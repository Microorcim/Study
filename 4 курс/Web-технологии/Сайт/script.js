// Общие утилиты
function getQueryParams() {
    const params = {};
    const search = window.location.search.substring(1);
    if (!search) return params;
    for (const part of search.split("&")) {
        const [key, value] = part.split("=");
        if (!key) continue;
        params[decodeURIComponent(key)] = decodeURIComponent(value || "");
    }
    return params;
}

function formatPrice(value) {
    const number = Number(value) || 0;
    return number.toLocaleString("ru-RU", { minimumFractionDigits: 2, maximumFractionDigits: 2 }) + " ₽";
}

function normalizeImagePath(path) {
    if (!path) return "";
    const p = String(path);
    if (p.startsWith("data:") || p.startsWith("http://") || p.startsWith("https://")) return p;
    // В БД иногда хранится "images/..." — тогда не добавляем префикс повторно
    if (p.startsWith("images/")) return p;
    return "images/" + p;
}

function productPlaceholderDataUri(name) {
    const safeName = String(name || "Товар").slice(0, 44);
    const svg = `
<svg xmlns="http://www.w3.org/2000/svg" width="800" height="600" viewBox="0 0 800 600">
  <defs>
    <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="#EFF6FF"/>
      <stop offset="0.6" stop-color="#FFFFFF"/>
      <stop offset="1" stop-color="#FFF7ED"/>
    </linearGradient>
    <linearGradient id="accent" x1="0" y1="0" x2="1" y2="0">
      <stop offset="0" stop-color="#2563EB"/>
      <stop offset="1" stop-color="#F97316"/>
    </linearGradient>
    <filter id="soft" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="14" stdDeviation="18" flood-color="#0F172A" flood-opacity="0.10"/>
    </filter>
  </defs>
  <rect width="800" height="600" rx="28" fill="url(#bg)"/>
  <path d="M0,420 C180,360 250,520 410,470 C560,422 620,300 800,360 L800,600 L0,600 Z" fill="#EEF2FF"/>
  <path d="M0,470 C210,420 280,570 460,520 C610,478 650,350 800,420 L800,600 L0,600 Z" fill="#FFEDD5"/>
  <circle cx="620" cy="170" r="120" fill="url(#accent)" opacity="0.18"/>
  <circle cx="180" cy="140" r="92" fill="url(#accent)" opacity="0.12"/>
  <g filter="url(#soft)">
    <rect x="92" y="208" width="616" height="200" rx="22" fill="#FFFFFF"/>
  </g>
  <rect x="120" y="228" width="92" height="10" rx="6" fill="url(#accent)"/>
  <text x="120" y="290" font-family="system-ui, -apple-system, Segoe UI, Arial" font-size="30" font-weight="800" fill="#111827">
    ${safeName.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;")}
  </text>
  <text x="120" y="334" font-family="system-ui, -apple-system, Segoe UI, Arial" font-size="16" font-weight="600" fill="#4B5563">
    SportStore • спортивные товары
  </text>
  <g opacity="0.85">
    <path d="M135 388 C210 348, 300 350, 365 390 C430 430, 520 430, 610 385" fill="none" stroke="url(#accent)" stroke-width="10" stroke-linecap="round"/>
    <path d="M140 388 C225 405, 295 405, 360 390" fill="none" stroke="#2563EB" stroke-width="4" stroke-linecap="round" opacity="0.35"/>
  </g>
</svg>`;
    return "data:image/svg+xml;charset=utf-8," + encodeURIComponent(svg.trim());
}

function createProductImage(imgPath, name) {
    const img = new Image();
    const placeholder = productPlaceholderDataUri(name);
    let normalized = normalizeImagePath(imgPath);
    if (!normalized) {
        const n = String(name || "").toLowerCase();
        if (n.includes("asics") && n.includes("gel")) normalized = "images/asics_gel.jpg";
        else if (n.includes("футбол")) normalized = "images/running_tshirt.jpg";
        else if (n.includes("шорт")) normalized = "images/running_shorts.jpg";
    }
    img.src = normalized || placeholder;
    img.alt = String(name || "Товар");
    img.loading = "lazy";
    img.decoding = "async";
    img.onerror = () => {
        if (img.src !== placeholder) img.src = placeholder;
    };
    return img;
}

function setFooterYear() {
    const el = document.getElementById("footer-year");
    if (el) {
        el.textContent = String(new Date().getFullYear());
    }
}

function initHeroVisual() {
    const visual = document.querySelector(".hero-visual");
    if (!visual) return;

    const reduceMotion = window.matchMedia && window.matchMedia("(prefers-reduced-motion: reduce)").matches;
    if (reduceMotion) return;

    visual.classList.add("hero-visual-interactive");

    let rafId = 0;
    let lastX = 0;
    let lastY = 0;

    function setVars() {
        rafId = 0;
        visual.style.setProperty("--hx", String(lastX));
        visual.style.setProperty("--hy", String(lastY));
    }

    function onMove(ev) {
        const rect = visual.getBoundingClientRect();
        const x = (ev.clientX - rect.left) / rect.width;
        const y = (ev.clientY - rect.top) / rect.height;

        // -1..1
        lastX = Math.max(-1, Math.min(1, (x - 0.5) * 2));
        lastY = Math.max(-1, Math.min(1, (y - 0.5) * 2));

        if (!rafId) rafId = requestAnimationFrame(setVars);
    }

    function onLeave() {
        lastX = 0;
        lastY = 0;
        if (!rafId) rafId = requestAnimationFrame(setVars);
    }

    visual.addEventListener("pointermove", onMove, { passive: true });
    visual.addEventListener("pointerleave", onLeave, { passive: true });
}

// Неблокирующие уведомления вместо alert/confirm
function showToast(message) {
    let container = document.querySelector(".toast-container");
    if (!container) {
        container = document.createElement("div");
        container.className = "toast-container";
        document.body.appendChild(container);
    }
    const toast = document.createElement("div");
    toast.className = "toast";
    toast.innerHTML = `<span class="toast-dot"></span><span>${message}</span>`;
    container.appendChild(toast);
    setTimeout(() => {
        toast.remove();
        if (!container.children.length) {
            container.remove();
        }
    }, 3400);
}

// Работа с корзиной в localStorage (для интерактивности на клиенте)
const CART_KEY = "sportstore_cart";

function loadCart() {
    try {
        const raw = localStorage.getItem(CART_KEY);
        if (!raw) return [];
        const data = JSON.parse(raw);
        return Array.isArray(data) ? data : [];
    } catch {
        return [];
    }
}

function saveCart(cart) {
    localStorage.setItem(CART_KEY, JSON.stringify(cart));
}

function addToCart(productId, quantity = 1) {
    const cart = loadCart();
    const existing = cart.find((item) => item.productId === productId);
    if (existing) {
        existing.quantity += quantity;
    } else {
        cart.push({ productId, quantity });
    }
    saveCart(cart);
}

function updateCartItem(productId, quantity) {
    let cart = loadCart();
    cart = cart
        .map((item) => (item.productId === productId ? { ...item, quantity } : item))
        .filter((item) => item.quantity > 0);
    saveCart(cart);
}

function clearCart() {
    localStorage.removeItem(CART_KEY);
}

// Загрузка товаров с сервера
async function fetchJson(url, options) {
    const response = await fetch(url, options);
    if (!response.ok) {
        throw new Error("Ошибка запроса: " + response.status);
    }
    return response.json();
}

// Главная страница: популярные и новые товары
async function initHomePage() {
    const popularContainer = document.getElementById("popular-products");
    const newContainer = document.getElementById("new-products");
    if (!popularContainer && !newContainer) return;

    try {
        if (popularContainer) {
            const popular = await fetchJson("api_products.php?popular=1");
            renderProductGrid(popularContainer, popular);
        }
        if (newContainer) {
            const newest = await fetchJson("api_products.php?new=1");
            renderProductGrid(newContainer, newest);
        }
    } catch (e) {
        if (popularContainer) {
            popularContainer.textContent = "Не удалось загрузить товары.";
        }
        if (newContainer) {
            newContainer.textContent = "Не удалось загрузить товары.";
        }
        console.error(e);
    }
}

// Каталог: фильтры, поиск, список
async function initCatalogPage() {
    const catalogContainer = document.getElementById("catalog-products");
    if (!catalogContainer) return;

    const filterForm = document.getElementById("filter-form");
    const resetButton = document.getElementById("reset-filters");
    const params = getQueryParams();

    // Меняем заголовок страницы каталога в зависимости от режима
    const titleEl = document.querySelector("h1.section-title");
    if (titleEl) {
        if (params.popular) {
            titleEl.textContent = "Популярные товары";
        } else if (params.new) {
            titleEl.textContent = "Новые поступления";
        } else if (params.q) {
            titleEl.textContent = `Результаты поиска: "${params.q}"`;
        } else {
            titleEl.textContent = "Каталог товаров";
        }
    }

    // Подгрузка категорий
    try {
        const categorySelect = document.getElementById("filter-category");
        if (categorySelect) {
            const categories = await fetchJson("api_categories.php");
            for (const cat of categories) {
                const option = document.createElement("option");
                option.value = String(cat.ID_категории);
                option.textContent = cat.Наименование_категории;
                categorySelect.appendChild(option);
            }
        }
    } catch (e) {
        console.error(e);
    }

    async function loadCatalog() {
        try {
            const formData = new FormData(filterForm);
            const searchParams = new URLSearchParams();

            for (const [key, value] of formData.entries()) {
                if (value) searchParams.set(key, value.toString());
            }

            // Учитываем q, popular, new из URL, чтобы не противоречить ТЗ по поиску/фильтрации
            if (params.q) searchParams.set("q", params.q);
            if (params.popular) searchParams.set("popular", "1");
            if (params.new) searchParams.set("new", "1");

            const url = "api_products.php" + (searchParams.toString() ? "?" + searchParams.toString() : "");
            const products = await fetchJson(url);
            renderProductGrid(catalogContainer, products);
        } catch (e) {
            catalogContainer.textContent = "Не удалось загрузить каталог.";
            console.error(e);
        }
    }

    filterForm.addEventListener("submit", (event) => {
        event.preventDefault();
        loadCatalog();
    });

    if (resetButton) {
        resetButton.addEventListener("click", () => {
            filterForm.reset();
            loadCatalog();
        });
    }

    await loadCatalog();
}

// Карточка товара
async function initProductPage() {
    const productPage = document.getElementById("product-page");
    if (!productPage) return;

    const params = getQueryParams();
    const id = Number(params.id);
    if (!id) {
        productPage.textContent = "Товар не найден.";
        return;
    }

    try {
        const product = await fetchJson("api_product.php?id=" + encodeURIComponent(String(id)));

        const wrapper = document.createElement("div");
        wrapper.className = "product-detail";
        wrapper.innerHTML = `
            <div class="product-detail-grid">
                <div class="product-detail-image" id="product-detail-image"></div>
                <div class="product-detail-info">
                    <h1>${product.Наименование_товара}</h1>
                    <p class="product-detail-price">${formatPrice(product.Цена)}</p>
                    <p class="product-detail-stock">${product.Наличие ? "В наличии" : "Нет в наличии"}</p>
                    <p class="product-detail-short">${product.Краткое_описание || ""}</p>
                    <h2>Описание</h2>
                    <p>${product.Полное_описание || ""}</p>
                    <h2>Характеристики</h2>
                    <p>${product.Характеристики || ""}</p>
                    <div class="product-detail-actions">
                        <label>
                            Количество
                            <input type="number" id="detail-qty" min="1" value="1">
                        </label>
                        <button id="detail-add-to-cart" class="btn btn-primary">Добавить в корзину</button>
                    </div>
                </div>
            </div>
        `;
        productPage.innerHTML = "";
        productPage.appendChild(wrapper);

        const imgHost = document.getElementById("product-detail-image");
        if (imgHost) {
            imgHost.innerHTML = "";
            imgHost.appendChild(createProductImage(product.Изображение, product.Наименование_товара));
        }

        // Похожие товары из той же категории
        if (product.ID_категории) {
            try {
                const related = await fetchJson(
                    "api_products.php?category=" + encodeURIComponent(String(product.ID_категории))
                );
                const filtered = related.filter((p) => p.ID_товара !== product.ID_товара).slice(0, 4);
                if (filtered.length) {
                    const section = document.createElement("section");
                    section.className = "section";
                    const container = document.createElement("div");
                    container.className = "container";
                    const title = document.createElement("h2");
                    title.className = "section-title";
                    title.textContent = "Похожие товары";
                    const grid = document.createElement("div");
                    grid.className = "product-grid";
                    container.appendChild(title);
                    container.appendChild(grid);
                    section.appendChild(container);
                    productPage.parentElement.appendChild(section);
                    renderProductGrid(grid, filtered, { allowSuggestions: false });
                }
            } catch (e) {
                console.error(e);
            }
        }

        const addBtn = document.getElementById("detail-add-to-cart");
        const qtyInput = document.getElementById("detail-qty");

        addBtn.addEventListener("click", () => {
            const quantity = Math.max(1, Number(qtyInput.value) || 1);
            addToCart(id, quantity);
            showToast("Товар добавлен в корзину.");
        });
    } catch (e) {
        productPage.textContent = "Не удалось загрузить данные о товаре.";
        console.error(e);
    }
}

// Отрисовка карточек товаров (повторно используется)
async function renderProductGrid(container, products, options = { allowSuggestions: true }) {
    container.innerHTML = "";
    if (!products || products.length === 0) {
        container.textContent = "Товары не найдены.";

        // Предложить другие товары, но не весь каталог
        if (options.allowSuggestions) {
            try {
                const suggestions = await fetchJson("api_products.php?popular=1");
                if (suggestions && suggestions.length) {
                    const block = document.createElement("div");
                    block.style.marginTop = "16px";
                    const title = document.createElement("h2");
                    title.className = "section-title";
                    title.textContent = "Вам также может понравиться";
                    const grid = document.createElement("div");
                    grid.className = "product-grid";
                    block.appendChild(title);
                    block.appendChild(grid);
                    container.parentElement.appendChild(block);
                    // Рекурсивный вызов, но без повторных подсказок
                    renderProductGrid(grid, suggestions, { allowSuggestions: false });
                }
            } catch (e) {
                console.error(e);
            }
        }
        return;
    }

    for (const p of products) {
        const article = document.createElement("article");
        article.className = "product-card";
        const imageWrapper = document.createElement("div");
        imageWrapper.className = "product-image-wrapper";
        imageWrapper.appendChild(createProductImage(p.Изображение, p.Наименование_товара));

        const title = document.createElement("h3");
        title.className = "product-title";
        const link = document.createElement("a");
        link.href = "product.html?id=" + encodeURIComponent(String(p.ID_товара));
        link.textContent = p.Наименование_товара;
        title.appendChild(link);

        const price = document.createElement("p");
        price.className = "product-price";
        price.textContent = formatPrice(p.Цена);

        const excerpt = document.createElement("p");
        excerpt.className = "product-excerpt";
        excerpt.textContent = p.Краткое_описание || "";

        const actions = document.createElement("form");
        actions.className = "product-actions";
        const hiddenId = document.createElement("input");
        hiddenId.type = "hidden";
        hiddenId.name = "product_id";
        hiddenId.value = String(p.ID_товара);
        const addBtn = document.createElement("button");
        addBtn.type = "button";
        addBtn.className = "btn btn-primary";
        addBtn.textContent = "В корзину";
        const more = document.createElement("a");
        more.className = "btn btn-ghost";
        more.href = link.href;
        more.textContent = "Подробнее";
        actions.appendChild(hiddenId);
        actions.appendChild(addBtn);
        actions.appendChild(more);

        article.appendChild(imageWrapper);
        article.appendChild(title);
        article.appendChild(price);
        article.appendChild(excerpt);
        article.appendChild(actions);

        addBtn.addEventListener("click", () => {
            const id = Number(hiddenId.value);
            addToCart(id, 1);
            showToast("Товар добавлен в корзину.");
        });

        container.appendChild(article);
    }
}

// Страница корзины
async function initCartPage() {
    const cartContainer = document.getElementById("cart-container");
    const summaryContainer = document.getElementById("cart-summary");
    if (!cartContainer || !summaryContainer) return;

    const cart = loadCart();
    if (cart.length === 0) {
        cartContainer.textContent = "Ваша корзина пуста.";
        summaryContainer.textContent = "";
        return;
    }

    try {
        // Получаем подробные данные по товарам корзины
        const ids = cart.map((i) => i.productId).join(",");
        const products = await fetchJson("api_products.php?ids=" + encodeURIComponent(ids));
        const productMap = new Map(products.map((p) => [p.ID_товара, p]));

        cartContainer.innerHTML = "";
        let total = 0;

        for (const item of cart) {
            const product = productMap.get(item.productId);
            if (!product) continue;

            const lineTotal = (Number(product.Цена) || 0) * item.quantity;
            total += lineTotal;

            const row = document.createElement("div");
            row.className = "cart-item";
            row.innerHTML = `
                <div class="cart-item-main">
                    <div class="cart-item-title">${product.Наименование_товара}</div>
                    <div class="cart-item-price">${formatPrice(product.Цена)}</div>
                </div>
                <div class="cart-item-controls">
                    <input type="number" min="1" value="${item.quantity}" class="cart-qty-input">
                    <span class="cart-item-total">${formatPrice(lineTotal)}</span>
                    <button class="btn btn-ghost cart-remove">Удалить</button>
                </div>
            `;

            const qtyInput = row.querySelector(".cart-qty-input");
            const totalEl = row.querySelector(".cart-item-total");
            const removeBtn = row.querySelector(".cart-remove");

            qtyInput.addEventListener("change", () => {
                const newQty = Math.max(1, Number(qtyInput.value) || 1);
                item.quantity = newQty;
                updateCartItem(item.productId, newQty);
                const newLineTotal = (Number(product.Цена) || 0) * newQty;
                totalEl.textContent = formatPrice(newLineTotal);
                // Пересчитать общую сумму
                initCartPage();
            });

            removeBtn.addEventListener("click", () => {
                updateCartItem(item.productId, 0);
                initCartPage();
            });

            cartContainer.appendChild(row);
        }

        summaryContainer.innerHTML = `<p><strong>Итого:</strong> ${formatPrice(total)}</p>`;
    } catch (e) {
        cartContainer.textContent = "Не удалось загрузить корзину.";
        summaryContainer.textContent = "";
        console.error(e);
    }
}

// Страница оформления заказа
async function initCheckoutPage() {
    const form = document.getElementById("checkout-form");
    const summary = document.getElementById("checkout-cart-summary");
    const message = document.getElementById("checkout-message");
    if (!form || !summary) return;

    const cart = loadCart();
    if (cart.length === 0) {
        summary.textContent = "Ваша корзина пуста. Добавьте товары перед оформлением заказа.";
        form.style.display = "none";
        return;
    }

    try {
        const ids = cart.map((i) => i.productId).join(",");
        const products = await fetchJson("api_products.php?ids=" + encodeURIComponent(ids));
        const productMap = new Map(products.map((p) => [p.ID_товара, p]));

        let total = 0;
        const list = document.createElement("ul");
        list.className = "checkout-list";

        for (const item of cart) {
            const product = productMap.get(item.productId);
            if (!product) continue;
            const lineTotal = (Number(product.Цена) || 0) * item.quantity;
            total += lineTotal;

            const li = document.createElement("li");
            li.textContent = `${product.Наименование_товара} × ${item.quantity} = ${formatPrice(
                lineTotal
            )}`;
            list.appendChild(li);
        }

        summary.innerHTML = "<h2>Состав заказа</h2>";
        summary.appendChild(list);
        const totalP = document.createElement("p");
        totalP.innerHTML = `<strong>Итого:</strong> ${formatPrice(total)}`;
        summary.appendChild(totalP);

        form.addEventListener("submit", async (event) => {
            event.preventDefault();
            message.textContent = "";

            const formData = new FormData(form);
            const payload = {
                full_name: formData.get("full_name"),
                phone: formData.get("phone"),
                email: formData.get("email"),
                address: formData.get("address"),
                delivery_method: formData.get("delivery_method"),
                comment: formData.get("comment"),
                cart: cart,
            };

            try {
                const response = await fetch("api_order.php", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                    },
                    body: JSON.stringify(payload),
                });
                if (!response.ok) {
                    throw new Error("Ошибка сервера");
                }
                const data = await response.json();
                if (data.success) {
                    clearCart();
                    // Отдельная страница успешного заказа
                    window.location.href = "order-success.html?order=" + encodeURIComponent(String(data.orderId));
                } else {
                    message.textContent = data.error || "Не удалось оформить заказ.";
                }
            } catch (e) {
                message.textContent = "Произошла ошибка при оформлении заказа.";
                console.error(e);
            }
        });
    } catch (e) {
        summary.textContent = "Не удалось загрузить состав заказа.";
        console.error(e);
    }
}

// Администрирование
async function initAdminPage() {
    const catTableBody = document.querySelector("#admin-categories-table tbody");
    const prodTableBody = document.querySelector("#admin-products-table tbody");
    if (!catTableBody || !prodTableBody) return;

    const catForm = document.getElementById("admin-category-form");
    const catIdInput = document.getElementById("admin-category-id");
    const catNameInput = document.getElementById("admin-category-name");
    const catDescrInput = document.getElementById("admin-category-description");
    const catResetBtn = document.getElementById("admin-category-reset");

    const prodForm = document.getElementById("admin-product-form");
    const prodIdInput = document.getElementById("admin-product-id");
    const prodCatSelect = document.getElementById("admin-product-category");
    const prodNameInput = document.getElementById("admin-product-name");
    const prodPriceInput = document.getElementById("admin-product-price");
    const prodShortInput = document.getElementById("admin-product-short");
    const prodFullInput = document.getElementById("admin-product-full");
    const prodFeatInput = document.getElementById("admin-product-features");
    const prodImgInput = document.getElementById("admin-product-image");
    const prodStockSelect = document.getElementById("admin-product-stock");
    const prodResetBtn = document.getElementById("admin-product-reset");
    const prodSearchInput = document.getElementById("admin-products-search");
    const prodSearchBtn = document.getElementById("admin-products-search-btn");
    const prodPagination = document.getElementById("admin-products-pagination");

    let currentProductPage = 1;

    async function loadCategories() {
        const categories = await fetchJson("admin_api.php?action=list_categories");
        catTableBody.innerHTML = "";
        prodCatSelect.innerHTML = "";

        for (const c of categories) {
            // таблица
            const tr = document.createElement("tr");
            tr.innerHTML = `
                <td>${c.ID_категории}</td>
                <td>${c.Наименование_категории}</td>
                <td>
                    <button class="admin-small-btn" data-edit-cat="${c.ID_категории}">Изменить</button>
                    <button class="admin-small-btn danger" data-delete-cat="${c.ID_категории}">Удалить</button>
                </td>
            `;
            catTableBody.appendChild(tr);

            // селект
            const opt = document.createElement("option");
            opt.value = String(c.ID_категории);
            opt.textContent = c.Наименование_категории;
            prodCatSelect.appendChild(opt);
        }

        // обработчики кнопок категорий
        catTableBody.querySelectorAll("[data-edit-cat]").forEach((btn) => {
            btn.addEventListener("click", () => {
                const id = Number(btn.getAttribute("data-edit-cat"));
                const row = categories.find((c) => c.ID_категории === id);
                if (!row) return;
                catIdInput.value = row.ID_категории;
                catNameInput.value = row.Наименование_категории;
                catDescrInput.value = row.Описание_категории || "";
            });
        });
        catTableBody.querySelectorAll("[data-delete-cat]").forEach((btn) => {
            btn.addEventListener("click", async () => {
                const id = Number(btn.getAttribute("data-delete-cat"));
                const rowEl = btn.closest("tr");
                if (rowEl && !rowEl.classList.contains("pending-delete")) {
                    rowEl.classList.add("pending-delete");
                    showToast("Нажмите ещё раз для удаления категории");
                    return;
                }
                const formData = new FormData();
                formData.set("action", "delete_category");
                formData.set("id", String(id));
                await fetch("admin_api.php", { method: "POST", body: formData });
                showToast("Категория удалена");
                loadCategories();
            });
        });
    }

    async function loadProducts(page = 1) {
        const search = prodSearchInput ? prodSearchInput.value.trim() : "";
        const params = new URLSearchParams();
        params.set("action", "list_products");
        params.set("page", String(page));
        if (search) params.set("q", search);
        const data = await fetchJson("admin_api.php?" + params.toString());
        currentProductPage = data.page;
        const products = data.items || [];
        const total = data.total || 0;
        const pageSize = data.pageSize || 25;

        prodTableBody.innerHTML = "";
        for (const p of products) {
            const tr = document.createElement("tr");
            tr.innerHTML = `
                <td>${p.ID_товара}</td>
                <td>${p.Наименование_товара}</td>
                <td>${p.Наименование_категории}</td>
                <td>${formatPrice(p.Цена)}</td>
                <td><span class="admin-badge">${p.Наличие ? "В наличии" : "Нет"}</span></td>
                <td>
                    <button class="admin-small-btn" data-edit-prod="${p.ID_товара}">Изменить</button>
                    <button class="admin-small-btn danger" data-delete-prod="${p.ID_товара}">Удалить</button>
                </td>
            `;
            prodTableBody.appendChild(tr);
        }

        prodTableBody.querySelectorAll("[data-edit-prod]").forEach((btn) => {
            btn.addEventListener("click", () => {
                const id = Number(btn.getAttribute("data-edit-prod"));
                const row = products.find((p) => p.ID_товара === id);
                if (!row) return;
                prodIdInput.value = row.ID_товара;
                prodCatSelect.value = String(row.ID_категории);
                prodNameInput.value = row.Наименование_товара;
                prodPriceInput.value = String(row.Цена);
                prodShortInput.value = row.Краткое_описание || "";
                prodFullInput.value = row.Полное_описание || "";
                prodFeatInput.value = row.Характеристики || "";
                prodImgInput.value = row.Изображение || "";
                prodStockSelect.value = String(row.Наличие);
            });
        });

        prodTableBody.querySelectorAll("[data-delete-prod]").forEach((btn) => {
            btn.addEventListener("click", async () => {
                const id = Number(btn.getAttribute("data-delete-prod"));
                const rowEl = btn.closest("tr");
                if (rowEl && !rowEl.classList.contains("pending-delete")) {
                    rowEl.classList.add("pending-delete");
                    showToast("Нажмите ещё раз для удаления товара");
                    return;
                }
                const formData = new FormData();
                formData.set("action", "delete_product");
                formData.set("id", String(id));
                await fetch("admin_api.php", { method: "POST", body: formData });
                showToast("Товар удален");
                loadProducts(currentProductPage);
            });
        });

        if (prodPagination) {
            const totalPages = Math.max(1, Math.ceil(total / pageSize));
            prodPagination.innerHTML = "";
            const info = document.createElement("div");
            info.textContent = `Страница ${currentProductPage} из ${totalPages} (товаров: ${total})`;
            const controls = document.createElement("div");
            controls.style.display = "flex";
            controls.style.gap = "6px";

            function makeBtn(label, targetPage, disabled) {
                const b = document.createElement("button");
                b.textContent = label;
                b.className = "admin-small-btn";
                if (disabled) {
                    b.disabled = true;
                    b.style.opacity = "0.6";
                } else {
                    b.addEventListener("click", () => loadProducts(targetPage));
                }
                return b;
            }

            controls.appendChild(makeBtn("« В начало", 1, currentProductPage === 1));
            controls.appendChild(makeBtn("‹ Предыдущая", currentProductPage - 1, currentProductPage === 1));
            controls.appendChild(makeBtn("Следующая ›", currentProductPage + 1, currentProductPage >= totalPages));
            controls.appendChild(makeBtn("В конец »", totalPages, currentProductPage >= totalPages));

            prodPagination.appendChild(info);
            prodPagination.appendChild(controls);
        }
    }

    // Сохранение категорий
    catForm.addEventListener("submit", async (event) => {
        event.preventDefault();
        const formData = new FormData(catForm);
        formData.set("action", "save_category");
        await fetch("admin_api.php", { method: "POST", body: formData });
        showToast("Категория сохранена");
        catForm.reset();
        catIdInput.value = "";
        loadCategories();
    });
    catResetBtn.addEventListener("click", () => {
        catForm.reset();
        catIdInput.value = "";
    });

    // Сохранение товаров
    prodForm.addEventListener("submit", async (event) => {
        event.preventDefault();
        const formData = new FormData(prodForm);
        formData.set("action", "save_product");
        await fetch("admin_api.php", { method: "POST", body: formData });
        showToast("Товар сохранен");
        prodForm.reset();
        prodIdInput.value = "";
        loadProducts();
    });
    prodResetBtn.addEventListener("click", () => {
        prodForm.reset();
        prodIdInput.value = "";
    });

    if (prodSearchBtn && prodSearchInput) {
        prodSearchBtn.addEventListener("click", () => {
            loadProducts(1);
        });
        prodSearchInput.addEventListener("keydown", (e) => {
            if (e.key === "Enter") {
                e.preventDefault();
                loadProducts(1);
            }
        });
    }

    await loadCategories();
    await loadProducts();
}
// Инициализация по странице
document.addEventListener("DOMContentLoaded", () => {
    setFooterYear();

    // Плавное появление секций и карточек при прокрутке
    const revealElements = document.querySelectorAll(".section, .product-card, .admin-card, .success-card");
    revealElements.forEach((el) => el.classList.add("reveal"));
    const observer = new IntersectionObserver(
        (entries) => {
            entries.forEach((entry) => {
                if (entry.isIntersecting) {
                    entry.target.classList.add("reveal-visible");
                    observer.unobserve(entry.target);
                }
            });
        },
        { threshold: 0.12 }
    );
    revealElements.forEach((el) => observer.observe(el));

    initHeroVisual();

    initHomePage();
    initCatalogPage();
    initProductPage();
    initCartPage();
    initCheckoutPage();
    initAdminPage();
});

