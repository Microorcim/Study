-- ============================================
-- Скрипт создания БД "Дом Пристарелых"
-- Синтаксис Microsoft Access
-- Запускайте каждую инструкцию отдельно (Access не поддерживает пакетное выполнение)
-- ============================================

-- Справочники (таблицы без зависимостей)
-- ============================================

-- Тип процедуры
CREATE TABLE ProcedureType (
    id COUNTER CONSTRAINT PK_ProcedureType PRIMARY KEY,
    procedure_name TEXT(200) NOT NULL,
    description MEMO
);

-- Способ оплаты
CREATE TABLE PaymentMethod (
    id COUNTER CONSTRAINT PK_PaymentMethod PRIMARY KEY,
    method_name TEXT(100) NOT NULL
);

-- Тип родства
CREATE TABLE RelationshipType (
    id COUNTER CONSTRAINT PK_RelationshipType PRIMARY KEY,
    relationship_name TEXT(100) NOT NULL
);

-- Должность (Position - зарезервированное слово, используем Positions)
CREATE TABLE Positions (
    id COUNTER CONSTRAINT PK_Positions PRIMARY KEY,
    position_name TEXT(100) NOT NULL
);

-- График работы
CREATE TABLE WorkSchedule (
    id COUNTER CONSTRAINT PK_WorkSchedule PRIMARY KEY,
    schedule_name TEXT(200) NOT NULL
);

-- Комнаты
CREATE TABLE Room (
    id COUNTER CONSTRAINT PK_Room PRIMARY KEY,
    room_number TEXT(20) NOT NULL,
    floor INTEGER NOT NULL,
    capacity INTEGER NOT NULL
);

-- Состояния здоровья
CREATE TABLE HealthStatus (
    id COUNTER CONSTRAINT PK_HealthStatus PRIMARY KEY,
    status_name TEXT(200) NOT NULL
);

-- Пол
CREATE TABLE Gender (
    id COUNTER CONSTRAINT PK_Gender PRIMARY KEY,
    gender_name TEXT(50) NOT NULL
);

-- Сотрудники
-- ============================================

CREATE TABLE Employee (
    id COUNTER CONSTRAINT PK_Employee PRIMARY KEY,
    last_name TEXT(100) NOT NULL,
    first_name TEXT(100) NOT NULL,
    middle_name TEXT(100),
    birth_date DATETIME NOT NULL,
    position_id INTEGER NOT NULL CONSTRAINT FK_Employee_Position REFERENCES Positions(id),
    phone TEXT(20),
    hire_date DATETIME NOT NULL,
    work_schedule_id INTEGER NOT NULL CONSTRAINT FK_Employee_WorkSchedule REFERENCES WorkSchedule(id)
);

-- Жильцы
-- ============================================

CREATE TABLE Resident (
    id COUNTER CONSTRAINT PK_Resident PRIMARY KEY,
    last_name TEXT(100) NOT NULL,
    first_name TEXT(100) NOT NULL,
    middle_name TEXT(100),
    birth_date DATETIME NOT NULL,
    move_in_date DATETIME NOT NULL,
    room_id INTEGER NOT NULL CONSTRAINT FK_Resident_Room REFERENCES Room(id),
    health_status_id INTEGER NOT NULL CONSTRAINT FK_Resident_HealthStatus REFERENCES HealthStatus(id),
    gender_id INTEGER NOT NULL CONSTRAINT FK_Resident_Gender REFERENCES Gender(id)
);

-- Медицинские процедуры, Платежи, Посещения
-- ============================================

CREATE TABLE MedicalProcedure (
    id COUNTER CONSTRAINT PK_MedicalProcedure PRIMARY KEY,
    procedure_type_id INTEGER NOT NULL CONSTRAINT FK_MedicalProcedure_Type REFERENCES ProcedureType(id),
    procedure_date DATETIME NOT NULL,
    employee_id INTEGER NOT NULL CONSTRAINT FK_MedicalProcedure_Employee REFERENCES Employee(id),
    resident_id INTEGER NOT NULL CONSTRAINT FK_MedicalProcedure_Resident REFERENCES Resident(id)
);

CREATE TABLE Payment (
    id COUNTER CONSTRAINT PK_Payment PRIMARY KEY,
    payment_date DATETIME NOT NULL,
    amount CURRENCY NOT NULL,
    payment_method_id INTEGER NOT NULL CONSTRAINT FK_Payment_Method REFERENCES PaymentMethod(id),
    resident_id INTEGER NOT NULL CONSTRAINT FK_Payment_Resident REFERENCES Resident(id)
);

CREATE TABLE Visit (
    id COUNTER CONSTRAINT PK_Visit PRIMARY KEY,
    visitor_name TEXT(200) NOT NULL,
    relationship_type_id INTEGER NOT NULL CONSTRAINT FK_Visit_RelationshipType REFERENCES RelationshipType(id),
    visit_date DATETIME NOT NULL,
    resident_id INTEGER NOT NULL CONSTRAINT FK_Visit_Resident REFERENCES Resident(id)
);
