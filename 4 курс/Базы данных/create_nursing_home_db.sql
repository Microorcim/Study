-- ============================================
-- БД "Дом Пристарелых" — Microsoft Access
-- ============================================
-- Access выполняет только ОДНУ инструкцию за раз.
-- Используйте папку access_tables: в каждом файле — одна таблица.
--
-- Порядок выполнения (по номерам файлов):
--   01–08: справочники
--   09: Employee, 10: Resident
--   11–13: MedicalProcedure, Payment, Visit
--
-- Как запускать: Создание → Конструктор запросов → Режим SQL,
-- вставьте содержимое нужного файла → Выполнить.
-- ============================================

CREATE TABLE ProcedureType (
    id COUNTER CONSTRAINT PK_ProcedureType PRIMARY KEY,
    procedure_name TEXT(200) NOT NULL,
    description MEMO
);
