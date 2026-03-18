<?php
declare(strict_types=1);
$qs = $_SERVER['QUERY_STRING'] ?? '';
header('Location: admin.html' . ($qs !== '' ? ('?' . $qs) : ''), true, 302);
exit;

