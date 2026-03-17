from __future__ import annotations

import sqlite3
from pathlib import Path


def main() -> None:
    db_path = Path(__file__).resolve().parent / "sport_store.db"
    con = sqlite3.connect(db_path)
    try:
        con.execute("PRAGMA foreign_keys = ON;")
        tables = [
            "Покупатель",
            "Категория",
            "Товар",
            "Заказ",
            "СоставЗаказа",
            "Корзина",
            "ЭлементКорзины",
        ]
        for t in tables:
            cnt = con.execute(f'SELECT COUNT(*) FROM "{t}"').fetchone()[0]
            print(f"{t}: {cnt}")
    finally:
        con.close()


if __name__ == "__main__":
    main()

