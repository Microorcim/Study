<?php
declare(strict_types=1);
require_once __DIR__ . '/db.php';

$db = getDbConnection();

// Популярные товары (условно: с наибольшей ценой или просто первые)
$popularStmt = $db->prepare('
    SELECT t.ID_товара, t.Наименование_товара, t.Цена, t.Краткое_описание, t.Изображение
    FROM Товар t
    WHERE t.Наличие = 1
    ORDER BY t.Цена DESC
    LIMIT 8
');
$popularResult = $popularStmt->execute();

// Новинки (условно: последние по ID)
$newStmt = $db->prepare('
    SELECT t.ID_товара, t.Наименование_товара, t.Цена, t.Краткое_описание, t.Изображение
    FROM Товар t
    WHERE t.Наличие = 1
    ORDER BY t.ID_товара DESC
    LIMIT 8
');
$newResult = $newStmt->execute();

include __DIR__ . '/header.php';
?>

<section class="hero">
    <div class="container hero-inner">
        <div class="hero-content">
            <h1>Интернет-магазин спортивных товаров</h1>
            <p>Экипировка, одежда, обувь и инвентарь для тех, кто живет спортом. Современный каталог, удобный поиск и быстрая доставка.</p>
            <div class="hero-actions">
                <a href="catalog.php" class="btn btn-primary">Перейти в каталог</a>
                <a href="catalog.php?popular=1" class="btn btn-outline">Популярные товары</a>
            </div>
        </div>
        <div class="hero-visual">
            <div class="hero-card">
                <span class="hero-badge">Спорт • Экипировка • Фитнес</span>
                <p>Подберите экипировку для тренировок и соревнований в несколько кликов.</p>
            </div>
        </div>
    </div>
</section>

<section class="section">
    <div class="container">
        <h2 class="section-title">Популярные товары</h2>
        <div class="product-grid">
            <?php while ($row = $popularResult->fetchArray(SQLITE3_ASSOC)): ?>
                <article class="product-card">
                    <div class="product-image-wrapper">
                        <?php if (!empty($row['Изображение'])): ?>
                            <img src="images/<?php echo htmlspecialchars($row['Изображение'], ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8'); ?>" alt="<?php echo htmlspecialchars($row['Наименование_товара'], ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8'); ?>">
                        <?php else: ?>
                            <div class="product-placeholder">Нет изображения</div>
                        <?php endif; ?>
                        <span class="badge badge-hit">Хит</span>
                    </div>
                    <h3 class="product-title">
                        <a href="product.php?id=<?php echo (int)$row['ID_товара']; ?>">
                            <?php echo htmlspecialchars($row['Наименование_товара'], ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8'); ?>
                        </a>
                    </h3>
                    <p class="product-price"><?php echo number_format((float)$row['Цена'], 2, ',', ' '); ?> ₽</p>
                    <p class="product-excerpt">
                        <?php echo htmlspecialchars((string)$row['Краткое_описание'], ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8'); ?>
                    </p>
                    <form action="cart_add.php" method="post" class="product-actions">
                        <input type="hidden" name="product_id" value="<?php echo (int)$row['ID_товара']; ?>">
                        <button type="submit" class="btn btn-primary">В корзину</button>
                        <a href="product.php?id=<?php echo (int)$row['ID_товара']; ?>" class="btn btn-ghost">Подробнее</a>
                    </form>
                </article>
            <?php endwhile; ?>
        </div>
    </div>
</section>

<section class="section section-alt">
    <div class="container">
        <h2 class="section-title">Новые поступления</h2>
        <div class="product-grid">
            <?php while ($row = $newResult->fetchArray(SQLITE3_ASSOC)): ?>
                <article class="product-card">
                    <div class="product-image-wrapper">
                        <?php if (!empty($row['Изображение'])): ?>
                            <img src="images/<?php echo htmlspecialchars($row['Изображение'], ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8'); ?>" alt="<?php echo htmlspecialchars($row['Наименование_товара'], ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8'); ?>">
                        <?php else: ?>
                            <div class="product-placeholder">Нет изображения</div>
                        <?php endif; ?>
                        <span class="badge badge-new">Новинка</span>
                    </div>
                    <h3 class="product-title">
                        <a href="product.php?id=<?php echo (int)$row['ID_товара']; ?>">
                            <?php echo htmlspecialchars($row['Наименование_товара'], ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8'); ?>
                        </a>
                    </h3>
                    <p class="product-price"><?php echo number_format((float)$row['Цена'], 2, ',', ' '); ?> ₽</p>
                    <p class="product-excerpt">
                        <?php echo htmlspecialchars((string)$row['Краткое_описание'], ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8'); ?>
                    </p>
                    <form action="cart_add.php" method="post" class="product-actions">
                        <input type="hidden" name="product_id" value="<?php echo (int)$row['ID_товара']; ?>">
                        <button type="submit" class="btn btn-primary">В корзину</button>
                        <a href="product.php?id=<?php echo (int)$row['ID_товара']; ?>" class="btn btn-ghost">Подробнее</a>
                    </form>
                </article>
            <?php endwhile; ?>
        </div>
    </div>
</section>

<?php
include __DIR__ . '/footer.php';
