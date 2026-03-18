<?php
declare(strict_types=1);
require_once __DIR__ . '/db.php';

header('Content-Type: application/json; charset=utf-8');

$db = getDbConnection();

$action = $_GET['action'] ?? $_POST['action'] ?? '';

switch ($action) {
    case 'list_categories':
        $result = $db->query('SELECT ID_категории, Наименование_категории, Описание_категории FROM Категория ORDER BY ID_категории ASC');
        $rows = [];
        while ($row = $result->fetchArray(SQLITE3_ASSOC)) {
            $rows[] = $row;
        }
        echo json_encode($rows, JSON_UNESCAPED_UNICODE);
        break;

    case 'save_category':
        $id = isset($_POST['id']) ? (int)$_POST['id'] : 0;
        $name = trim((string)($_POST['name'] ?? ''));
        $description = trim((string)($_POST['description'] ?? ''));
        if ($name === '') {
            http_response_code(400);
            echo json_encode(['success' => false, 'error' => 'Наименование категории обязательно'], JSON_UNESCAPED_UNICODE);
            break;
        }
        if ($id > 0) {
            $stmt = $db->prepare('UPDATE Категория SET Наименование_категории = :name, Описание_категории = :descr WHERE ID_категории = :id');
            $stmt->bindValue(':id', $id, SQLITE3_INTEGER);
        } else {
            $stmt = $db->prepare('INSERT INTO Категория (Наименование_категории, Описание_категории) VALUES (:name, :descr)');
        }
        $stmt->bindValue(':name', $name, SQLITE3_TEXT);
        $stmt->bindValue(':descr', $description, SQLITE3_TEXT);
        $stmt->execute();
        echo json_encode(['success' => true], JSON_UNESCAPED_UNICODE);
        break;

    case 'delete_category':
        $id = isset($_POST['id']) ? (int)$_POST['id'] : 0;
        if ($id <= 0) {
            http_response_code(400);
            echo json_encode(['success' => false, 'error' => 'Некорректный ID категории'], JSON_UNESCAPED_UNICODE);
            break;
        }
        $stmt = $db->prepare('DELETE FROM Категория WHERE ID_категории = :id');
        $stmt->bindValue(':id', $id, SQLITE3_INTEGER);
        $stmt->execute();
        echo json_encode(['success' => true], JSON_UNESCAPED_UNICODE);
        break;

    case 'list_products':
        $conditions = [];
        $params = [];
        $page = max(1, (int)($_GET['page'] ?? 1));
        $pageSize = 25;
        $offset = ($page - 1) * $pageSize;
        if (!empty($_GET['q'])) {
            $conditions[] = '(t.Наименование_товара LIKE :q OR t.Краткое_описание LIKE :q OR t.Полное_описание LIKE :q)';
            $params[':q'] = '%' . $_GET['q'] . '%';
        }
        if (!empty($_GET['category'])) {
            $conditions[] = 't.ID_категории = :cat';
            $params[':cat'] = (int)$_GET['category'];
        }
        $whereSql = $conditions ? ('WHERE ' . implode(' AND ', $conditions)) : '';

        // Считаем общее количество для пагинации
        $countSql = "
            SELECT COUNT(*)
            FROM Товар t
            $whereSql
        ";
        $countStmt = $db->prepare($countSql);
        foreach ($params as $name => $value) {
            $countStmt->bindValue($name, $value, is_int($value) ? SQLITE3_INTEGER : SQLITE3_TEXT);
        }
        $countResult = $countStmt->execute();
        $total = (int)$countResult->fetchArray(SQLITE3_NUM)[0];

        // Получаем страницу записей
        $sql = "
            SELECT t.ID_товара,
                   t.Наименование_товара,
                   t.Цена,
                   t.Наличие,
                   t.Краткое_описание,
                   t.Полное_описание,
                   t.Характеристики,
                   t.Изображение,
                   t.ID_категории,
                   c.Наименование_категории
            FROM Товар t
            JOIN Категория c ON c.ID_категории = t.ID_категории
            $whereSql
            ORDER BY t.ID_товара DESC
            LIMIT :limit OFFSET :offset
        ";
        $stmt = $db->prepare($sql);
        foreach ($params as $name => $value) {
            $stmt->bindValue($name, $value, is_int($value) ? SQLITE3_INTEGER : SQLITE3_TEXT);
        }
        $stmt->bindValue(':limit', $pageSize, SQLITE3_INTEGER);
        $stmt->bindValue(':offset', $offset, SQLITE3_INTEGER);
        $result = $stmt->execute();
        $rows = [];
        while ($row = $result->fetchArray(SQLITE3_ASSOC)) {
            $rows[] = $row;
        }
        echo json_encode(['items' => $rows, 'total' => $total, 'page' => $page, 'pageSize' => $pageSize], JSON_UNESCAPED_UNICODE);
        break;

    case 'save_product':
        $id = isset($_POST['id']) ? (int)$_POST['id'] : 0;
        $categoryId = (int)($_POST['category_id'] ?? 0);
        $name = trim((string)($_POST['name'] ?? ''));
        $price = (float)($_POST['price'] ?? 0);
        $short = trim((string)($_POST['short_desc'] ?? ''));
        $full = trim((string)($_POST['full_desc'] ?? ''));
        $features = trim((string)($_POST['features'] ?? ''));
        $image = trim((string)($_POST['image'] ?? ''));
        $inStock = (int)($_POST['in_stock'] ?? 1);

        if ($categoryId <= 0 || $name === '') {
            http_response_code(400);
            echo json_encode(['success' => false, 'error' => 'Не заполнены обязательные поля товара'], JSON_UNESCAPED_UNICODE);
            break;
        }

        if ($id > 0) {
            $stmt = $db->prepare('
                UPDATE Товар
                SET ID_категории = :cat,
                    Наименование_товара = :name,
                    Цена = :price,
                    Краткое_описание = :short,
                    Полное_описание = :full,
                    Характеристики = :features,
                    Изображение = :image,
                    Наличие = :stock
                WHERE ID_товара = :id
            ');
            $stmt->bindValue(':id', $id, SQLITE3_INTEGER);
        } else {
            $stmt = $db->prepare('
                INSERT INTO Товар
                (ID_категории, Наименование_товара, Цена, Краткое_описание, Полное_описание, Характеристики, Изображение, Наличие)
                VALUES (:cat, :name, :price, :short, :full, :features, :image, :stock)
            ');
        }

        $stmt->bindValue(':cat', $categoryId, SQLITE3_INTEGER);
        $stmt->bindValue(':name', $name, SQLITE3_TEXT);
        $stmt->bindValue(':price', $price, SQLITE3_FLOAT);
        $stmt->bindValue(':short', $short, SQLITE3_TEXT);
        $stmt->bindValue(':full', $full, SQLITE3_TEXT);
        $stmt->bindValue(':features', $features, SQLITE3_TEXT);
        $stmt->bindValue(':image', $image, SQLITE3_TEXT);
        $stmt->bindValue(':stock', $inStock, SQLITE3_INTEGER);
        $stmt->execute();

        echo json_encode(['success' => true], JSON_UNESCAPED_UNICODE);
        break;

    case 'delete_product':
        $id = isset($_POST['id']) ? (int)$_POST['id'] : 0;
        if ($id <= 0) {
            http_response_code(400);
            echo json_encode(['success' => false, 'error' => 'Некорректный ID товара'], JSON_UNESCAPED_UNICODE);
            break;
        }
        $stmt = $db->prepare('DELETE FROM Товар WHERE ID_товара = :id');
        $stmt->bindValue(':id', $id, SQLITE3_INTEGER);
        $stmt->execute();
        echo json_encode(['success' => true], JSON_UNESCAPED_UNICODE);
        break;

    default:
        http_response_code(400);
        echo json_encode(['success' => false, 'error' => 'Неизвестное действие'], JSON_UNESCAPED_UNICODE);
}

