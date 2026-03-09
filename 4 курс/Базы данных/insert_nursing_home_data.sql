-- ============================================
-- Скрипт добавления данных в БД "Дом Пристарелых"
-- Синтаксис Microsoft Access
--
-- ВАЖНО: Access выполняет только ОДНУ SQL-инструкцию за раз.
-- Если вставить весь файл в режим SQL — вторая и последующие INSERT вызовут ошибку.
--
-- Варианты:
-- 1) Запускать каждый INSERT по одному (копировать и выполнять по строке).
-- 2) Использовать VBA-модуль InsertNursingHomeData.bas: Alt+F11 → запустить InsertAllData.
-- Порядок вставки важен из-за внешних ключей!
-- ============================================

-- ============================================
-- 1. Справочники (вставлять первыми)
-- ============================================

-- ProcedureType (Тип процедуры)
INSERT INTO ProcedureType (procedure_name, description) VALUES ('Измерение давления', 'Контроль артериального давления');
INSERT INTO ProcedureType (procedure_name, description) VALUES ('Инъекция', 'Внутримышечные и подкожные инъекции');
INSERT INTO ProcedureType (procedure_name, description) VALUES ('Массаж', 'Лечебный массаж для улучшения кровообращения');
INSERT INTO ProcedureType (procedure_name, description) VALUES ('Физиотерапия', 'Электрофорез, УВЧ и другие процедуры');
INSERT INTO ProcedureType (procedure_name, description) VALUES ('Перевязка', 'Обработка и перевязка ран');

-- PaymentMethod (Способ оплаты)
INSERT INTO PaymentMethod (method_name) VALUES ('Наличные');
INSERT INTO PaymentMethod (method_name) VALUES ('Банковская карта');
INSERT INTO PaymentMethod (method_name) VALUES ('Безналичный перевод');
INSERT INTO PaymentMethod (method_name) VALUES ('Социальные выплаты');

-- RelationshipType (Тип родства)
INSERT INTO RelationshipType (relationship_name) VALUES ('Сын');
INSERT INTO RelationshipType (relationship_name) VALUES ('Дочь');
INSERT INTO RelationshipType (relationship_name) VALUES ('Внук');
INSERT INTO RelationshipType (relationship_name) VALUES ('Внучка');
INSERT INTO RelationshipType (relationship_name) VALUES ('Брат');
INSERT INTO RelationshipType (relationship_name) VALUES ('Сестра');
INSERT INTO RelationshipType (relationship_name) VALUES ('Друг семьи');

-- Positions (Должности)
INSERT INTO Positions (position_name) VALUES ('Медсестра');
INSERT INTO Positions (position_name) VALUES ('Санитар');
INSERT INTO Positions (position_name) VALUES ('Врач-терапевт');
INSERT INTO Positions (position_name) VALUES ('Сиделка');
INSERT INTO Positions (position_name) VALUES ('Администратор');

-- WorkSchedule (График работы)
INSERT INTO WorkSchedule (schedule_name) VALUES ('Дневная смена (8:00-20:00)');
INSERT INTO WorkSchedule (schedule_name) VALUES ('Ночная смена (20:00-8:00)');
INSERT INTO WorkSchedule (schedule_name) VALUES ('Сменный график 2/2');
INSERT INTO WorkSchedule (schedule_name) VALUES ('Пятидневка (9:00-18:00)');

-- Room (Комнаты)
INSERT INTO Room (room_number, floor, capacity) VALUES ('101', 1, 2);
INSERT INTO Room (room_number, floor, capacity) VALUES ('102', 1, 2);
INSERT INTO Room (room_number, floor, capacity) VALUES ('103', 1, 1);
INSERT INTO Room (room_number, floor, capacity) VALUES ('201', 2, 2);
INSERT INTO Room (room_number, floor, capacity) VALUES ('202', 2, 2);
INSERT INTO Room (room_number, floor, capacity) VALUES ('301', 3, 1);

-- HealthStatus (Состояния здоровья)
INSERT INTO HealthStatus (status_name) VALUES ('Удовлетворительное');
INSERT INTO HealthStatus (status_name) VALUES ('Средней тяжести');
INSERT INTO HealthStatus (status_name) VALUES ('Требуется постоянный уход');
INSERT INTO HealthStatus (status_name) VALUES ('Стабильное');

-- Gender (Пол)
INSERT INTO Gender (gender_name) VALUES ('Мужской');
INSERT INTO Gender (gender_name) VALUES ('Женский');

-- ============================================
-- 2. Сотрудники (id позиций 1-5, графиков 1-4)
-- ============================================

INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('Иванова', 'Мария', 'Петровна', #1985-03-15#, 1, '+7-916-111-22-33', #2020-01-10#, 1);
INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('Петров', 'Алексей', 'Сергеевич', #1978-07-22#, 3, '+7-916-222-33-44', #2019-06-01#, 4);
INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('Сидорова', 'Елена', 'Викторовна', #1990-11-08#, 1, '+7-916-333-44-55', #2021-03-15#, 2);
INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('Козлов', 'Дмитрий', 'Иванович', #1982-01-30#, 2, '+7-916-444-55-66', #2020-09-01#, 3);
INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('Николаева', 'Ольга', 'Андреевна', #1975-05-12#, 4, '+7-916-555-66-77', #2018-02-20#, 1);
INSERT INTO Employee (last_name, first_name, middle_name, birth_date, position_id, phone, hire_date, work_schedule_id) VALUES ('Морозов', 'Игорь', NULL, #1988-09-25#, 5, '+7-916-666-77-88', #2022-01-05#, 4);

-- ============================================
-- 3. Жильцы (комнаты 1-6, здоровье 1-4, пол 1-2)
-- ============================================

INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('Смирнов', 'Николай', 'Фёдорович', #1940-04-20#, #2021-05-10#, 1, 1, 1);
INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('Кузнецова', 'Анна', 'Михайловна', #1938-08-15#, #2020-11-01#, 1, 2, 2);
INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('Попов', 'Виктор', 'Александрович', #1945-12-03#, #2022-02-20#, 2, 4, 1);
INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('Васильева', 'Галина', 'Ивановна', #1942-06-28#, #2021-08-15#, 2, 1, 2);
INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('Фёдоров', 'Борис', 'Петрович', #1936-02-14#, #2019-03-01#, 3, 3, 1);
INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('Михайлова', 'Татьяна', 'Сергеевна', #1948-10-09#, #2022-06-01#, 4, 2, 2);
INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('Новиков', 'Евгений', 'Дмитриевич', #1943-07-17#, #2020-04-12#, 4, 4, 1);
INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('Волкова', 'Лидия', 'Николаевна', #1939-01-25#, #2021-01-20#, 5, 2, 2);
INSERT INTO Resident (last_name, first_name, middle_name, birth_date, move_in_date, room_id, health_status_id, gender_id) VALUES ('Алексеев', 'Степан', 'Григорьевич', #1941-11-30#, #2022-09-10#, 6, 1, 1);

-- ============================================
-- 4. Медицинские процедуры (тип 1-5, сотрудник 1-6, жилец 1-9)
-- ============================================

INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-01-15 09:00#, 1, 1);
INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-01-15 09:30#, 1, 2);
INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (2, #2024-01-16 10:00#, 1, 5);
INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (3, #2024-01-17 11:00#, 5, 1);
INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-01-18 09:00#, 3, 3);
INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (4, #2024-01-19 14:00#, 2, 5);
INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (5, #2024-01-20 10:30#, 1, 7);
INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (1, #2024-01-21 09:00#, 1, 8);
INSERT INTO MedicalProcedure (procedure_type_id, procedure_date, employee_id, resident_id) VALUES (2, #2024-01-22 10:00#, 1, 4);

-- ============================================
-- 5. Платежи (способ 1-4, жилец 1-9)
-- ============================================

INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-01-05#, 45000, 3, 1);
INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-01-05#, 45000, 3, 2);
INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-01-06#, 50000, 2, 3);
INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-01-07#, 45000, 4, 4);
INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-01-08#, 55000, 3, 5);
INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-01-10#, 45000, 1, 6);
INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-01-10#, 48000, 2, 7);
INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-01-12#, 45000, 3, 8);
INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-01-15#, 45000, 3, 9);
INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-01#, 45000, 3, 1);
INSERT INTO Payment (payment_date, amount, payment_method_id, resident_id) VALUES (#2024-02-01#, 45000, 3, 2);

-- ============================================
-- 6. Посещения (тип родства 1-7, жилец 1-9)
-- ============================================

INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('Смирнов Андрей Николаевич', 1, #2024-01-14 14:00#, 1);
INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('Кузнецова Елена', 2, #2024-01-15 11:00#, 2);
INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('Попова Мария', 2, #2024-01-16 16:00#, 3);
INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('Васильев Игорь', 1, #2024-01-17 10:00#, 4);
INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('Фёдорова Наталья', 2, #2024-01-18 15:00#, 5);
INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('Михайлов Дмитрий', 1, #2024-01-20 12:00#, 6);
INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('Новикова Ольга', 2, #2024-01-21 14:30#, 7);
INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('Волков Сергей', 1, #2024-01-22 11:00#, 8);
INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('Алексеева Вера', 2, #2024-01-23 13:00#, 9);
INSERT INTO Visit (visitor_name, relationship_type_id, visit_date, resident_id) VALUES ('Смирнова Анна (внучка)', 4, #2024-01-28 15:00#, 1);
