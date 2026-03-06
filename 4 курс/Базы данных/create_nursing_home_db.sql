-- ============================================
-- Скрипт создания БД "Дом Пристарелых"
-- ============================================

-- Создание базы данных (раскомментируйте при необходимости)
-- CREATE DATABASE [Дом_Пристарелых];
-- GO
-- USE [Дом_Пристарелых];
-- GO

-- Справочники (таблицы без зависимостей)
-- ============================================

CREATE TABLE [Тип процедуры] (
    [ID Тип процедуры] INT IDENTITY(1,1) NOT NULL,
    [Название процедуры] NVARCHAR(200) NOT NULL,
    [Описание] NVARCHAR(MAX) NULL,
    CONSTRAINT PK_Тип_процедуры PRIMARY KEY ([ID Тип процедуры])
);

CREATE TABLE [Способ оплаты] (
    [ID Способ оплаты] INT IDENTITY(1,1) NOT NULL,
    [Способ оплаты] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_Способ_оплаты PRIMARY KEY ([ID Способ оплаты])
);

CREATE TABLE [Тип родства] (
    [ID Тип родства] INT IDENTITY(1,1) NOT NULL,
    [Тип родства] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_Тип_родства PRIMARY KEY ([ID Тип родства])
);

CREATE TABLE [Должность] (
    [ID Должность] INT IDENTITY(1,1) NOT NULL,
    [Должность] NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_Должность PRIMARY KEY ([ID Должность])
);

CREATE TABLE [График работы] (
    [ID График работы] INT IDENTITY(1,1) NOT NULL,
    [График работы] NVARCHAR(200) NOT NULL,
    CONSTRAINT PK_График_работы PRIMARY KEY ([ID График работы])
);

CREATE TABLE [Комнаты] (
    [ID Комнаты] INT IDENTITY(1,1) NOT NULL,
    [Номер комнаты] NVARCHAR(20) NOT NULL,
    [Этаж] INT NOT NULL,
    [Вместимость] INT NOT NULL,
    CONSTRAINT PK_Комнаты PRIMARY KEY ([ID Комнаты])
);

CREATE TABLE [Состояния здоровья] (
    [ID Состояния здоровье] INT IDENTITY(1,1) NOT NULL,
    [Состояние здоровья] NVARCHAR(200) NOT NULL,
    CONSTRAINT PK_Состояния_здоровья PRIMARY KEY ([ID Состояния здоровье])
);

CREATE TABLE [Пол] (
    [ID Пол] INT IDENTITY(1,1) NOT NULL,
    [Пол] NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Пол PRIMARY KEY ([ID Пол])
);

-- Таблица сотрудников (зависит от Должность, График работы)
-- ============================================

CREATE TABLE [Сотрудники] (
    [ID Сотрудника] INT IDENTITY(1,1) NOT NULL,
    [Фамилия] NVARCHAR(100) NOT NULL,
    [Имя] NVARCHAR(100) NOT NULL,
    [Отчество] NVARCHAR(100) NULL,
    [Дата рождения] DATE NOT NULL,
    [ID Должность] INT NOT NULL,
    [Телефон] NVARCHAR(20) NULL,
    [Дата приема на работу] DATE NOT NULL,
    [ID График работы] INT NOT NULL,
    CONSTRAINT PK_Сотрудники PRIMARY KEY ([ID Сотрудника]),
    CONSTRAINT FK_Сотрудники_Должность FOREIGN KEY ([ID Должность]) REFERENCES [Должность]([ID Должность]),
    CONSTRAINT FK_Сотрудники_График_работы FOREIGN KEY ([ID График работы]) REFERENCES [График работы]([ID График работы])
);

-- Таблица жильцов (зависит от Комнаты, Состояния здоровья, Пол)
-- ============================================

CREATE TABLE [Жильцы] (
    [ID Жильцы] INT IDENTITY(1,1) NOT NULL,
    [Фамилия] NVARCHAR(100) NOT NULL,
    [Имя] NVARCHAR(100) NOT NULL,
    [Отчество] NVARCHAR(100) NULL,
    [Дата рождения] DATE NOT NULL,
    [Дата заселения] DATE NOT NULL,
    [ID Комнаты] INT NOT NULL,
    [ID Состояния здоровье] INT NOT NULL,
    [ID Пол] INT NOT NULL,
    CONSTRAINT PK_Жильцы PRIMARY KEY ([ID Жильцы]),
    CONSTRAINT FK_Жильцы_Комнаты FOREIGN KEY ([ID Комнаты]) REFERENCES [Комнаты]([ID Комнаты]),
    CONSTRAINT FK_Жильцы_Состояния_здоровья FOREIGN KEY ([ID Состояния здоровье]) REFERENCES [Состояния здоровья]([ID Состояния здоровье]),
    CONSTRAINT FK_Жильцы_Пол FOREIGN KEY ([ID Пол]) REFERENCES [Пол]([ID Пол])
);

-- Таблицы с операционными данными (зависимости от жильцов/сотрудников)
-- ============================================

CREATE TABLE [Медицинские процедуры] (
    [ID Медицинские процедуры] INT IDENTITY(1,1) NOT NULL,
    [ID Типа процедуры] INT NOT NULL,
    [Дата процедуры] DATETIME NOT NULL,
    [ID Сотрудника] INT NOT NULL,
    [ID Жильца] INT NOT NULL,
    CONSTRAINT PK_Медицинские_процедуры PRIMARY KEY ([ID Медицинские процедуры]),
    CONSTRAINT FK_МедПроцедуры_Тип_процедуры FOREIGN KEY ([ID Типа процедуры]) REFERENCES [Тип процедуры]([ID Тип процедуры]),
    CONSTRAINT FK_МедПроцедуры_Сотрудник FOREIGN KEY ([ID Сотрудника]) REFERENCES [Сотрудники]([ID Сотрудника]),
    CONSTRAINT FK_МедПроцедуры_Жилец FOREIGN KEY ([ID Жильца]) REFERENCES [Жильцы]([ID Жильцы])
);

CREATE TABLE [Платежи] (
    [ID Платежи] INT IDENTITY(1,1) NOT NULL,
    [Дата платежа] DATETIME NOT NULL,
    [Сумма] DECIMAL(18,2) NOT NULL,
    [ID Способа оплаты] INT NOT NULL,
    [ID Жильца] INT NOT NULL,
    CONSTRAINT PK_Платежи PRIMARY KEY ([ID Платежи]),
    CONSTRAINT FK_Платежи_Способ_оплаты FOREIGN KEY ([ID Способа оплаты]) REFERENCES [Способ оплаты]([ID Способ оплаты]),
    CONSTRAINT FK_Платежи_Жилец FOREIGN KEY ([ID Жильца]) REFERENCES [Жильцы]([ID Жильцы])
);

CREATE TABLE [Посещения] (
    [ID Посещения] INT IDENTITY(1,1) NOT NULL,
    [Имя посетителя] NVARCHAR(200) NOT NULL,
    [ID Тип родства] INT NOT NULL,
    [Дата посещения] DATETIME NOT NULL,
    [ID Жильца] INT NOT NULL,
    CONSTRAINT PK_Посещения PRIMARY KEY ([ID Посещения]),
    CONSTRAINT FK_Посещения_Тип_родства FOREIGN KEY ([ID Тип родства]) REFERENCES [Тип родства]([ID Тип родства]),
    CONSTRAINT FK_Посещения_Жилец FOREIGN KEY ([ID Жильца]) REFERENCES [Жильцы]([ID Жильцы])
);
