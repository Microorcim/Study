<?php
declare(strict_types=1);
require_once __DIR__ . '/db.php';

header('Content-Type: application/json; charset=utf-8');

$db = getDbConnection();
$result = $db->query('SELECT ID_категории, Наименование_категории FROM Категория ORDER BY Наименование_категории ASC');

$categories = [];
while ($row = $result->fetchArray(SQLITE3_ASSOC)) {
    $categories[] = $row;
}

echo json_encode($categories, JSON_UNESCAPED_UNICODE);

