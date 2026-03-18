<?php
declare(strict_types=1);
require_once __DIR__ . '/db.php';

header('Content-Type: application/json; charset=utf-8');

$db = getDbConnection();

// Базовые условия (наличие товара) и параметры для prepared statement
$conditions = ['t.Наличие = 1'];
$params = [];
$ids = [];

// Поиск по наименованию и описаниям/характеристикам
if (!empty($_GET['q'])) {
    $conditions[] = '(t.Наименование_товара LIKE :q
                      OR t.Краткое_описание LIKE :q
                      OR t.Полное_описание LIKE :q
                      OR t.Характеристики LIKE :q)';
    $params[':q'] = '%' . $_GET['q'] . '%';
}

// Фильтр по категории
if (!empty($_GET['category'])) {
    $conditions[] = 't.ID_категории = :category';
    $params[':category'] = (int)$_GET['category'];
}

// Фильтр по цене
if (!empty($_GET['min_price'])) {
    $conditions[] = 't.Цена >= :min_price';
    $params[':min_price'] = (float)$_GET['min_price'];
}
if (!empty($_GET['max_price'])) {
    $conditions[] = 't.Цена <= :max_price';
    $params[':max_price'] = (float)$_GET['max_price'];
}

// Поддержка фильтра по нескольким ID (для корзины)
if (!empty($_GET['ids'])) {
    $ids = array_filter(array_map('intval', explode(',', (string)$_GET['ids'])));
    if ($ids) {
        $placeholders = implode(',', array_fill(0, count($ids), '?'));
        $conditions[] = "t.ID_товара IN ($placeholders)";
    }
}

$orderBy = 't.ID_товара ASC';
$limitSql = '';

// Популярные / новые (как в index, но через API)
if (!empty($_GET['popular'])) {
    $orderBy = 't.Цена DESC';
    $limitSql = 'LIMIT 8';
}
if (!empty($_GET['new'])) {
    $orderBy = 't.ID_товара DESC';
    $limitSql = 'LIMIT 8';
}

$whereSql = $conditions ? ('WHERE ' . implode(' AND ', $conditions)) : '';

$sql = "
    SELECT t.ID_товара, t.Наименование_товара, t.Цена, t.Краткое_описание, t.Изображение
    FROM Товар t
    $whereSql
    ORDER BY $orderBy
    $limitSql
";

$stmt = $db->prepare($sql);

// Привязка именованных параметров
foreach ($params as $name => $value) {
    if (is_int($value)) {
        $stmt->bindValue($name, $value, SQLITE3_INTEGER);
    } elseif (is_float($value)) {
        $stmt->bindValue($name, $value, SQLITE3_FLOAT);
    } else {
        $stmt->bindValue($name, (string)$value, SQLITE3_TEXT);
    }
}

// Привязка позиционных параметров для списка ID (если есть)
if ($ids) {
    $index = 1;
    foreach ($ids as $id) {
        $stmt->bindValue($index, $id, SQLITE3_INTEGER);
        $index++;
    }
}

$result = $stmt->execute();
if ($result === false) {
    echo json_encode([]);
    exit;
}

$products = [];
while ($row = $result->fetchArray(SQLITE3_ASSOC)) {
    $products[] = $row;
}

echo json_encode($products, JSON_UNESCAPED_UNICODE);

