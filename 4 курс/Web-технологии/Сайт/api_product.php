<?php
declare(strict_types=1);
require_once __DIR__ . '/db.php';

header('Content-Type: application/json; charset=utf-8');

if (empty($_GET['id'])) {
    http_response_code(400);
    echo json_encode(['error' => 'Не указан идентификатор товара'], JSON_UNESCAPED_UNICODE);
    exit;
}

$id = (int)$_GET['id'];

$db = getDbConnection();
$stmt = $db->prepare('
    SELECT ID_товара, ID_категории, Наименование_товара, Цена, Краткое_описание, Полное_описание, Характеристики, Изображение, Наличие
    FROM Товар
    WHERE ID_товара = :id
');
$stmt->bindValue(':id', $id, SQLITE3_INTEGER);
$result = $stmt->execute();
$row = $result->fetchArray(SQLITE3_ASSOC);

if (!$row) {
    http_response_code(404);
    echo json_encode(['error' => 'Товар не найден'], JSON_UNESCAPED_UNICODE);
    exit;
}

echo json_encode($row, JSON_UNESCAPED_UNICODE);

