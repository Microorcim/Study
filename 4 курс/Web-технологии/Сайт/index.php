<?php
declare(strict_types=1);

// Этот проект использует HTML+CSS+JS для страниц.
// PHP оставлен только для работы с SQLite (api_*.php).
// Чтобы не путаться со старыми .php страницами — перенаправляем на index.html.
$qs = $_SERVER['QUERY_STRING'] ?? '';
header('Location: index.html' . ($qs !== '' ? ('?' . $qs) : ''), true, 302);
exit;
?>
