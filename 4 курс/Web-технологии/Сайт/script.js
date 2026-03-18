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

function setFooterYear() {
    const el = document.getElementById("footer-year");
    if (el) {
        el.textContent = String(new Date().getFullYear());
    }
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
                <div class="product-detail-image">
                    ${
                        product.Изображение
                            ? `<img src="images/${encodeURIComponent(product.Изображение)}" alt="${product.Наименование_товара}">`
                            : '<div class="product-placeholder">Нет изображения</div>'
                    }
                </div>
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
        article.innerHTML = `
            <div class="product-image-wrapper">
                ${
                    p.Изображение
                        ? `<img src="images/${encodeURIComponent(p.Изображение)}" alt="${p.Наименование_товара}">`
                        : '<div class="product-placeholder">Нет изображения</div>'
                }
            </div>
            <h3 class="product-title">
                <a href="product.html?id=${encodeURIComponent(String(p.ID_товара))}">
                    ${p.Наименование_товара}
                </a>
            </h3>
            <p class="product-price">${formatPrice(p.Цена)}</p>
            <p class="product-excerpt">${p.Краткое_описание || ""}</p>
            <form class="product-actions">
                <input type="hidden" name="product_id" value="${p.ID_товара}">
                <button type="button" class="btn btn-primary">В корзину</button>
                <a href="product.html?id=${encodeURIComponent(String(p.ID_товара))}" class="btn btn-ghost">Подробнее</a>
            </form>
        `;

        const addBtn = article.querySelector("button.btn-primary");
        const hiddenId = article.querySelector('input[name="product_id"]');
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

    initHomePage();
    initCatalogPage();
    initProductPage();
    initCartPage();
    initCheckoutPage();
    initAdminPage();
});

