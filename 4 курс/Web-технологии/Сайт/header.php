<?php
declare(strict_types=1);
?>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>SportStore — Интернет-магазин спортивных товаров</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<header class="site-header">
    <div class="container header-inner">
        <a href="index.php" class="logo">
            <span class="logo-mark">Sport</span><span class="logo-accent">Store</span>
        </a>
        <nav class="main-nav">
            <a href="catalog.php">Каталог</a>
            <a href="catalog.php?popular=1">Популярное</a>
            <a href="catalog.php?new=1">Новинки</a>
        </nav>
        <div class="header-actions">
            <form class="search-form" action="search.php" method="get">
                <input type="text" name="q" placeholder="Поиск по товарам..." required>
                <button type="submit">Найти</button>
            </form>
            <a href="cart.php" class="icon-button cart-link">Корзина</a>
        </div>
    </div>
</header>
<main class="site-main">

