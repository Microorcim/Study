<?php
// Подключение к базе данных SQLite sport_store.db
// Предполагается, что файл sport_store.db лежит в той же папке, что и этот скрипт.

declare(strict_types=1);

function getDbConnection(): SQLite3
{
    static $db = null;

    if ($db instanceof SQLite3) {
        return $db;
    }

    $dbPath = __DIR__ . DIRECTORY_SEPARATOR . 'sport_store.db';

    if (!file_exists($dbPath)) {
        die('Файл базы данных sport_store.db не найден.');
    }

    $db = new SQLite3($dbPath);
    $db->exec('PRAGMA foreign_keys = ON;');
    $db->exec('PRAGMA encoding = "UTF-8";');

    return $db;
}

