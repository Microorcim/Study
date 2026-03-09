# -*- coding: utf-8 -*-
"""
Загрузка данных из JSON в базу Microsoft Access (Дом пристарелых).
Выбор файла JSON и файла базы .accdb через диалоги.
"""

import json
import os
import re
from datetime import datetime
from tkinter import Tk, BooleanVar, filedialog, messagebox, ttk, scrolledtext

try:
    import pyodbc
except ImportError:
    print("Установите pyodbc: pip install pyodbc")
    raise

# Порядок таблиц (с учётом внешних ключей): справочники -> Employee -> Resident -> остальные
TABLE_ORDER = [
    "ProcedureType",
    "PaymentMethod",
    "RelationshipType",
    "Positions",
    "WorkSchedule",
    "Room",
    "HealthStatus",
    "Gender",
    "Employee",
    "Resident",
    "MedicalProcedure",
    "Payment",
    "Visit",
]

# Порядок для удаления (сначала дочерние таблицы, потом родительские)
REVERSE_TABLE_ORDER = list(reversed(TABLE_ORDER))

# Ссылки на другие таблицы: для подстановки реальных id после вставки (Access AutoNumber не сбрасывается после DELETE)
FK_COLUMNS = {
    "Employee": [("position_id", "Positions"), ("work_schedule_id", "WorkSchedule")],
    "Resident": [("room_id", "Room"), ("health_status_id", "HealthStatus"), ("gender_id", "Gender")],
    "MedicalProcedure": [("procedure_type_id", "ProcedureType"), ("employee_id", "Employee"), ("resident_id", "Resident")],
    "Payment": [("payment_method_id", "PaymentMethod"), ("resident_id", "Resident")],
    "Visit": [("relationship_type_id", "RelationshipType"), ("resident_id", "Resident")],
}

# Колонки для вставки по таблицам (без id — он COUNTER/AutoNumber)
TABLE_COLUMNS = {
    "ProcedureType": ["procedure_name", "description"],
    "PaymentMethod": ["method_name"],
    "RelationshipType": ["relationship_name"],
    "Positions": ["position_name"],
    "WorkSchedule": ["schedule_name"],
    "Room": ["room_number", "floor", "capacity"],
    "HealthStatus": ["status_name"],
    "Gender": ["gender_name"],
    "Employee": [
        "last_name", "first_name", "middle_name", "birth_date",
        "position_id", "phone", "hire_date", "work_schedule_id",
    ],
    "Resident": [
        "last_name", "first_name", "middle_name", "birth_date",
        "move_in_date", "room_id", "health_status_id", "gender_id",
    ],
    "MedicalProcedure": [
        "procedure_type_id", "procedure_date", "employee_id", "resident_id",
    ],
    "Payment": ["payment_date", "amount", "payment_method_id", "resident_id"],
    "Visit": ["visitor_name", "relationship_type_id", "visit_date", "resident_id"],
}


def parse_date(value):
    """Парсит строку даты/времени в datetime или date."""
    if value is None:
        return None
    if isinstance(value, datetime):
        return value
    s = value.strip()
    if not s:
        return None
    # только дата: 1985-03-15
    if re.match(r"^\d{4}-\d{2}-\d{2}$", s):
        return datetime.strptime(s, "%Y-%m-%d")
    # дата и время: 2024-01-01 09:00:00
    if " " in s:
        return datetime.strptime(s[:19], "%Y-%m-%d %H:%M:%S")
    return datetime.strptime(s[:10], "%Y-%m-%d")


def get_connection(db_path):
    """Подключение к Access. Пробуем оба распространённых драйвера."""
    path = os.path.abspath(db_path)
    if not os.path.isfile(path):
        raise FileNotFoundError(f"Файл базы не найден: {path}")
    drivers = [
        "Microsoft Access Driver (*.mdb, *.accdb)",
        "Microsoft ACE ODBC Driver (*.mdb, *.accdb)",
    ]
    for driver in drivers:
        try:
            conn_str = f"DRIVER={{{driver}}};DBQ={path};"
            return pyodbc.connect(conn_str)
        except pyodbc.Error:
            continue
    raise RuntimeError(
        "Не найден драйвер ODBC для Access. Установите Microsoft Access Database Engine (ACE)."
    )


def load_json(json_path):
    """Загружает JSON и возвращает словарь. Игнорирует ключи, не являющиеся таблицами."""
    with open(json_path, "r", encoding="utf-8") as f:
        data = json.load(f)
    return {k: v for k, v in data.items() if k in TABLE_ORDER and isinstance(v, list)}


def row_to_values(row, columns, table_name, id_maps):
    """Преобразует строку JSON в список значений для INSERT.
    Для столбцов-ссылок (FK) подставляется реальный id из id_maps (т.к. в Access AutoNumber не сбрасывается после DELETE)."""
    fk_map = FK_COLUMNS.get(table_name, {})
    if not isinstance(fk_map, list):
        fk_map = []
    fk_refs = {col: ref_table for col, ref_table in fk_map}
    values = []
    for col in columns:
        v = row.get(col)
        if col in fk_refs and v is not None:
            ref_table = fk_refs[col]
            v = id_maps.get(ref_table, {}).get(v, v)
        if v is None:
            values.append(None)
        elif col in (
            "birth_date", "hire_date", "move_in_date",
            "procedure_date", "payment_date", "visit_date",
        ):
            values.append(parse_date(v) if isinstance(v, str) else v)
        else:
            values.append(v)
    return values


def clear_tables(cursor, log_callback):
    """Удаляет все записи из таблиц (в обратном порядке зависимостей)."""
    for table_name in REVERSE_TABLE_ORDER:
        try:
            cursor.execute(f"DELETE FROM [{table_name}]")
            log_callback(f"  Очищена таблица [{table_name}]\n")
        except pyodbc.Error as e:
            log_callback(f"  Предупреждение при очистке [{table_name}]: {e}\n")


def insert_table(cursor, table_name, rows, log_callback, id_maps):
    """Вставляет все строки в таблицу. После каждой вставки сохраняет сгенерированный id в id_maps для подстановки в дочерние таблицы."""
    if not rows:
        log_callback(f"  [{table_name}] записей нет, пропуск.\n")
        return
    columns = TABLE_COLUMNS[table_name]
    placeholders = ", ".join("?" for _ in columns)
    cols_str = ", ".join(f"[{c}]" for c in columns)
    sql = f"INSERT INTO [{table_name}] ({cols_str}) VALUES ({placeholders})"
    if table_name not in id_maps:
        id_maps[table_name] = {}
    count = 0
    for i, row in enumerate(rows):
        try:
            vals = row_to_values(row, columns, table_name, id_maps)
            cursor.execute(sql, vals)
            cursor.execute("SELECT @@IDENTITY")
            row_id = cursor.fetchone()[0]
            if row_id is not None:
                id_maps[table_name][i + 1] = int(row_id)
            count += 1
        except Exception as e:
            log_callback(f"  Ошибка в [{table_name}]: {e}\n  Строка: {row}\n")
            raise
    log_callback(f"  [{table_name}] вставлено записей: {count}\n")


def import_json_to_access(json_path, db_path, log_callback, clear_first=True):
    """Загружает данные из JSON в Access. log_callback(str) — вывод лога.
    Если clear_first=True, перед вставкой очищаются все таблицы (чтобы повторный запуск не ломал целостность)."""
    log_callback("Загрузка JSON...\n")
    data = load_json(json_path)
    log_callback("Подключение к базе...\n")
    conn = get_connection(db_path)
    try:
        cursor = conn.cursor()
        if clear_first:
            log_callback("Очистка таблиц...\n")
            clear_tables(cursor, log_callback)
        id_maps = {}
        for table_name in TABLE_ORDER:
            rows = data.get(table_name, [])
            log_callback(f"Таблица {table_name}...\n")
            insert_table(cursor, table_name, rows, log_callback, id_maps)
        conn.commit()
        log_callback("Готово. Все данные загружены.\n")
    finally:
        conn.close()


def main():
    json_path = [None]
    db_path = [None]

    def choose_json():
        path = filedialog.askopenfilename(
            title="Выберите файл JSON",
            filetypes=[("JSON", "*.json"), ("Все файлы", "*.*")],
            initialdir=os.path.dirname(os.path.abspath(__file__)),
        )
        if path:
            json_path[0] = path
            lbl_json.config(text=path)

    def choose_db():
        path = filedialog.askopenfilename(
            title="Выберите базу Access",
            filetypes=[("Access", "*.accdb;*.mdb"), ("Все файлы", "*.*")],
            initialdir=os.path.dirname(os.path.abspath(__file__)),
        )
        if path:
            db_path[0] = path
            lbl_db.config(text=path)

    root = Tk()
    root.title("Загрузка JSON в Access — Дом пристарелых")
    root.geometry("700x450")
    root.minsize(500, 350)

    frm = ttk.Frame(root, padding=10)
    frm.pack(fill="both", expand=True)

    ttk.Label(frm, text="Файл JSON:").grid(row=0, column=0, sticky="w", pady=2)
    lbl_json = ttk.Label(frm, text="(не выбран)", foreground="gray")
    lbl_json.grid(row=0, column=1, sticky="ew", padx=5, pady=2)
    ttk.Button(frm, text="Выбрать JSON", command=choose_json).grid(row=0, column=2, pady=2)

    ttk.Label(frm, text="База Access:").grid(row=1, column=0, sticky="w", pady=2)
    lbl_db = ttk.Label(frm, text="(не выбран)", foreground="gray")
    lbl_db.grid(row=1, column=1, sticky="ew", padx=5, pady=2)
    ttk.Button(frm, text="Выбрать базу", command=choose_db).grid(row=1, column=2, pady=2)

    frm.columnconfigure(1, weight=1)

    clear_before_var = BooleanVar(value=True)
    ttk.Checkbutton(
        frm,
        text="Очистить таблицы перед загрузкой (рекомендуется при повторном запуске)",
        variable=clear_before_var,
    ).grid(row=2, column=0, columnspan=3, sticky="w", pady=5)

    def run_import():
        if not json_path[0]:
            messagebox.showwarning("Внимание", "Сначала выберите файл JSON.")
            return
        if not db_path[0]:
            messagebox.showwarning("Внимание", "Сначала выберите файл базы Access.")
            return
        log_area.delete("1.0", "end")

        def log(s):
            log_area.insert("end", s)
            log_area.see("end")

        try:
            import_json_to_access(
                json_path[0], db_path[0], log, clear_first=clear_before_var.get()
            )
            messagebox.showinfo("Успех", "Данные успешно загружены в базу.")
        except Exception as e:
            log(str(e) + "\n")
            messagebox.showerror("Ошибка", str(e))

    ttk.Button(frm, text="Загрузить данные в базу", command=run_import).grid(
        row=3, column=0, columnspan=3, pady=15
    )

    ttk.Label(frm, text="Лог:").grid(row=4, column=0, sticky="nw", pady=5)
    log_area = scrolledtext.ScrolledText(frm, height=15, width=70, wrap="word")
    log_area.grid(row=5, column=0, columnspan=3, sticky="nsew", pady=5)
    frm.rowconfigure(5, weight=1)

    root.mainloop()


if __name__ == "__main__":
    main()
