# -*- coding: utf-8 -*-
"""Собирает полный nursing_home_data.json из частей и генерирует MedicalProcedure, Payment, Visit."""
import json
import random
from datetime import datetime, timedelta

# Загружаем основную часть (без Resident, MedicalProcedure, Payment, Visit)
with open("nursing_home_data.json", "r", encoding="utf-8") as f:
    content = f.read()
# Убираем последнюю "  ]," и дописываем остальное
content = content.rstrip().rstrip(",")

# Загружаем Resident
with open("nursing_home_data_residents.json", "r", encoding="utf-8") as f:
    residents_block = f.read().strip().rstrip(",")

# Генерируем MedicalProcedure: procedure_type_id 1-7, employee_id 1-19, resident_id 1-45
procedures = []
base = datetime(2024, 1, 1)
for i in range(95):
    procedures.append({
        "procedure_type_id": (i % 7) + 1,
        "procedure_date": (base + timedelta(days=i, hours=9 + (i % 8))).strftime("%Y-%m-%d %H:%M:%S"),
        "employee_id": (i % 19) + 1,
        "resident_id": (i % 45) + 1
    })

# Payment: по 2-3 платежа на жильца
payments = []
for r in range(1, 46):
    for m in range(1, 4):
        payments.append({
            "payment_date": f"2024-0{m}-05",
            "amount": 45000 + random.randint(-2000, 3000),
            "payment_method_id": (r + m) % 5 + 1,
            "resident_id": r
        })

# Visit: по 1-2 визита на жильца
visitors = ["Андрей", "Елена", "Мария", "Дмитрий", "Наталья", "Сергей", "Ольга", "Игорь", "Вера", "Николай",
            "Татьяна", "Павел", "Анна", "Виктор", "Ирина", "Александр", "Светлана", "Михаил", "Екатерина", "Владимир"]
visits = []
for r in range(1, 46):
    for v in range(1, 2 + (r % 2)):
        visits.append({
            "visitor_name": f"{visitors[(r + v) % 20]} (родственник)",
            "relationship_type_id": (r + v) % 7 + 1,
            "visit_date": (base + timedelta(days=r * 3 + v, hours=10 + v)).strftime("%Y-%m-%d %H:%M:%S"),
            "resident_id": r
        })

# Собираем JSON вручную для корректной кодировки
out = content + ",\n" + residents_block + "\n  "
out += '"MedicalProcedure": ' + json.dumps(procedures, ensure_ascii=False, indent=2) + ",\n  "
out += '"Payment": ' + json.dumps(payments, ensure_ascii=False, indent=2) + ",\n  "
out += '"Visit": ' + json.dumps(visits, ensure_ascii=False, indent=2) + "\n}\n"

with open("nursing_home_data.json", "w", encoding="utf-8") as f:
    f.write(out)

total = (7+5+7+6+5+13+5+2+19+45+len(procedures)+len(payments)+len(visits))
print(f"Готово. Записей: {total}")
