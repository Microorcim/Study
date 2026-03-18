<?php
declare(strict_types=1);
require_once __DIR__ . '/db.php';

header('Content-Type: application/json; charset=utf-8');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'error' => 'Неверный метод запроса'], JSON_UNESCAPED_UNICODE);
    exit;
}

$raw = file_get_contents('php://input');
if ($raw === false) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'Нет данных'], JSON_UNESCAPED_UNICODE);
    exit;
}

$data = json_decode($raw, true);
if (!is_array($data)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'Неверный формат данных'], JSON_UNESCAPED_UNICODE);
    exit;
}

// Валидация основных полей (соответствует форме ТЗ)
foreach (['full_name', 'phone', 'email', 'address', 'delivery_method', 'cart'] as $field) {
    if (empty($data[$field])) {
        http_response_code(400);
        echo json_encode(['success' => false, 'error' => 'Отсутствует поле: ' . $field], JSON_UNESCAPED_UNICODE);
        exit;
    }
}

$cart = $data['cart'];
if (!is_array($cart) || count($cart) === 0) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'Корзина пуста'], JSON_UNESCAPED_UNICODE);
    exit;
}

try {
    $db = getDbConnection();
    $db->exec('BEGIN');

    // 1. Создаём покупателя
    $stmtBuyer = $db->prepare('
        INSERT INTO Покупатель (ФИО, Телефон, Email, Адрес_доставки)
        VALUES (:fio, :phone, :email, :address)
    ');
    $stmtBuyer->bindValue(':fio', (string)$data['full_name'], SQLITE3_TEXT);
    $stmtBuyer->bindValue(':phone', (string)$data['phone'], SQLITE3_TEXT);
    $stmtBuyer->bindValue(':email', (string)$data['email'], SQLITE3_TEXT);
    $stmtBuyer->bindValue(':address', (string)$data['address'], SQLITE3_TEXT);
    $stmtBuyer->execute();
    $buyerId = $db->lastInsertRowID();

    // 2. Создаём корзину (отражение таблицы "Корзина" в ТЗ)
    $stmtCart = $db->prepare('
        INSERT INTO Корзина (ID_покупателя, Дата_создания)
        VALUES (:buyer_id, :created_at)
    ');
    $stmtCart->bindValue(':buyer_id', $buyerId, SQLITE3_INTEGER);
    $stmtCart->bindValue(':created_at', date('Y-m-d H:i:s'), SQLITE3_TEXT);
    $stmtCart->execute();
    $cartId = $db->lastInsertRowID();

    // Получаем данные о товарах
    $ids = array_unique(array_map('intval', array_column($cart, 'productId')));
    if (!$ids) {
        throw new RuntimeException('Пустой список товаров');
    }

    $placeholders = implode(',', array_fill(0, count($ids), '?'));
    $sqlProducts = "SELECT ID_товара, Цена FROM Товар WHERE ID_товара IN ($placeholders)";
    $stmtProducts = $db->prepare($sqlProducts);
    $i = 1;
    foreach ($ids as $id) {
        $stmtProducts->bindValue($i, $id, SQLITE3_INTEGER);
        $i++;
    }
    $resultProducts = $stmtProducts->execute();
    $priceMap = [];
    while ($row = $resultProducts->fetchArray(SQLITE3_ASSOC)) {
        $priceMap[(int)$row['ID_товара']] = (float)$row['Цена'];
    }

    // 3. Заполняем элементы корзины
    $total = 0.0;
    $stmtCartItem = $db->prepare('
        INSERT INTO ЭлементКорзины (ID_товара, ID_корзины, Количество)
        VALUES (:product_id, :cart_id, :qty)
    ');

    foreach ($cart as $item) {
        $productId = (int)$item['productId'];
        $qty = max(1, (int)$item['quantity']);
        if (!isset($priceMap[$productId])) {
            continue;
        }
        $price = $priceMap[$productId];
        $total += $price * $qty;

        $stmtCartItem->bindValue(':product_id', $productId, SQLITE3_INTEGER);
        $stmtCartItem->bindValue(':cart_id', $cartId, SQLITE3_INTEGER);
        $stmtCartItem->bindValue(':qty', $qty, SQLITE3_INTEGER);
        $stmtCartItem->execute();
    }

    // 4. Создаём заказ
    $stmtOrder = $db->prepare('
        INSERT INTO Заказ (ID_покупателя, Дата_заказа, Статус_заказа, Итоговая_сумма, Комментарий)
        VALUES (:buyer_id, :created_at, :status, :total, :comment)
    ');
    $stmtOrder->bindValue(':buyer_id', $buyerId, SQLITE3_INTEGER);
    $stmtOrder->bindValue(':created_at', date('Y-m-d H:i:s'), SQLITE3_TEXT);
    $stmtOrder->bindValue(':status', 'Новый', SQLITE3_TEXT);
    $stmtOrder->bindValue(':total', $total, SQLITE3_FLOAT);
    $comment = 'Способ доставки: ' . (string)$data['delivery_method'] . '. ' . (string)($data['comment'] ?? '');
    $stmtOrder->bindValue(':comment', $comment, SQLITE3_TEXT);
    $stmtOrder->execute();
    $orderId = $db->lastInsertRowID();

    // 5. Состав заказа
    $stmtOrderItem = $db->prepare('
        INSERT INTO СоставЗаказа (ID_товара, ID_заказа, Количество, Цена_на_момент_заказа)
        VALUES (:product_id, :order_id, :qty, :price)
    ');

    foreach ($cart as $item) {
        $productId = (int)$item['productId'];
        $qty = max(1, (int)$item['quantity']);
        if (!isset($priceMap[$productId])) {
            continue;
        }
        $price = $priceMap[$productId];

        $stmtOrderItem->bindValue(':product_id', $productId, SQLITE3_INTEGER);
        $stmtOrderItem->bindValue(':order_id', $orderId, SQLITE3_INTEGER);
        $stmtOrderItem->bindValue(':qty', $qty, SQLITE3_INTEGER);
        $stmtOrderItem->bindValue(':price', $price, SQLITE3_FLOAT);
        $stmtOrderItem->execute();
    }

    $db->exec('COMMIT');

    echo json_encode(['success' => true, 'orderId' => $orderId], JSON_UNESCAPED_UNICODE);
} catch (Throwable $e) {
    if (isset($db)) {
        $db->exec('ROLLBACK');
    }
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => 'Ошибка при оформлении заказа'], JSON_UNESCAPED_UNICODE);
}

