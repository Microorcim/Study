-- ============================================
-- Скрипт создания БД "Дом Пристарелых"
-- Имена таблиц и столбцов на латинице (без русских символов)
-- ============================================

-- Создание базы данных (раскомментируйте при необходимости)
-- CREATE DATABASE NursingHome;
-- GO
-- USE NursingHome;
-- GO

-- Справочники (таблицы без зависимостей)
-- ============================================

-- Тип процедуры
CREATE TABLE ProcedureType (
    id INT AUTO_INCREMENT NOT NULL,
    procedure_name NVARCHAR(200) NOT NULL,
    description NVARCHAR(MAX) NULL,
    CONSTRAINT PK_ProcedureType PRIMARY KEY (id)
);

-- Способ оплаты
CREATE TABLE PaymentMethod (
    id INT AUTO_INCREMENT NOT NULL,
    method_name NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_PaymentMethod PRIMARY KEY (id)
);

-- Тип родства
CREATE TABLE RelationshipType (
    id INT AUTO_INCREMENT NOT NULL,
    relationship_name NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_RelationshipType PRIMARY KEY (id)
);

-- Должность
CREATE TABLE Position (
    id INT AUTO_INCREMENT NOT NULL,
    position_name NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_Position PRIMARY KEY (id)
);

-- График работы
CREATE TABLE WorkSchedule (
    id INT AUTO_INCREMENT NOT NULL,
    schedule_name NVARCHAR(200) NOT NULL,
    CONSTRAINT PK_WorkSchedule PRIMARY KEY (id)
);

-- Комнаты
CREATE TABLE Room (
    id INT AUTO_INCREMENT NOT NULL,
    room_number NVARCHAR(20) NOT NULL,
    floor INT NOT NULL,
    capacity INT NOT NULL,
    CONSTRAINT PK_Room PRIMARY KEY (id)
);

-- Состояния здоровья
CREATE TABLE HealthStatus (
    id INT AUTO_INCREMENT NOT NULL,
    status_name NVARCHAR(200) NOT NULL,
    CONSTRAINT PK_HealthStatus PRIMARY KEY (id)
);

-- Пол
CREATE TABLE Gender (
    id INT AUTO_INCREMENT NOT NULL,
    gender_name NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Gender PRIMARY KEY (id)
);

-- Сотрудники (зависит от Должность, График работы)
-- ============================================

CREATE TABLE Employee (
    id INT AUTO_INCREMENT NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    first_name NVARCHAR(100) NOT NULL,
    middle_name NVARCHAR(100) NULL,
    birth_date DATE NOT NULL,
    position_id INT NOT NULL,
    phone NVARCHAR(20) NULL,
    hire_date DATE NOT NULL,
    work_schedule_id INT NOT NULL,
    CONSTRAINT PK_Employee PRIMARY KEY (id),
    CONSTRAINT FK_Employee_Position FOREIGN KEY (position_id) REFERENCES Position(id),
    CONSTRAINT FK_Employee_WorkSchedule FOREIGN KEY (work_schedule_id) REFERENCES WorkSchedule(id)
);

-- Жильцы (зависит от Комнаты, Состояния здоровья, Пол)
-- ============================================

CREATE TABLE Resident (
    id INT AUTO_INCREMENT NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    first_name NVARCHAR(100) NOT NULL,
    middle_name NVARCHAR(100) NULL,
    birth_date DATE NOT NULL,
    move_in_date DATE NOT NULL,
    room_id INT NOT NULL,
    health_status_id INT NOT NULL,
    gender_id INT NOT NULL,
    CONSTRAINT PK_Resident PRIMARY KEY (id),
    CONSTRAINT FK_Resident_Room FOREIGN KEY (room_id) REFERENCES Room(id),
    CONSTRAINT FK_Resident_HealthStatus FOREIGN KEY (health_status_id) REFERENCES HealthStatus(id),
    CONSTRAINT FK_Resident_Gender FOREIGN KEY (gender_id) REFERENCES Gender(id)
);

-- Медицинские процедуры, Платежи, Посещения
-- ============================================

CREATE TABLE MedicalProcedure (
    id INT AUTO_INCREMENT NOT NULL,
    procedure_type_id INT NOT NULL,
    procedure_date DATETIME NOT NULL,
    employee_id INT NOT NULL,
    resident_id INT NOT NULL,
    CONSTRAINT PK_MedicalProcedure PRIMARY KEY (id),
    CONSTRAINT FK_MedicalProcedure_Type FOREIGN KEY (procedure_type_id) REFERENCES ProcedureType(id),
    CONSTRAINT FK_MedicalProcedure_Employee FOREIGN KEY (employee_id) REFERENCES Employee(id),
    CONSTRAINT FK_MedicalProcedure_Resident FOREIGN KEY (resident_id) REFERENCES Resident(id)
);

CREATE TABLE Payment (
    id INT AUTO_INCREMENT NOT NULL,
    payment_date DATETIME NOT NULL,
    amount DECIMAL(18,2) NOT NULL,
    payment_method_id INT NOT NULL,
    resident_id INT NOT NULL,
    CONSTRAINT PK_Payment PRIMARY KEY (id),
    CONSTRAINT FK_Payment_Method FOREIGN KEY (payment_method_id) REFERENCES PaymentMethod(id),
    CONSTRAINT FK_Payment_Resident FOREIGN KEY (resident_id) REFERENCES Resident(id)
);

CREATE TABLE Visit (
    id INT AUTO_INCREMENT NOT NULL,
    visitor_name NVARCHAR(200) NOT NULL,
    relationship_type_id INT NOT NULL,
    visit_date DATETIME NOT NULL,
    resident_id INT NOT NULL,
    CONSTRAINT PK_Visit PRIMARY KEY (id),
    CONSTRAINT FK_Visit_RelationshipType FOREIGN KEY (relationship_type_id) REFERENCES RelationshipType(id),
    CONSTRAINT FK_Visit_Resident FOREIGN KEY (resident_id) REFERENCES Resident(id)
);
