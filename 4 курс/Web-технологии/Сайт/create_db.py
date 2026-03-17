from __future__ import annotations

import sqlite3
from pathlib import Path


def main() -> None:
    base_dir = Path(__file__).resolve().parent
    sql_path = base_dir / "create_sport_store.sql"
    db_path = base_dir / "sport_store.db"

    sql_text = sql_path.read_text(encoding="utf-8")

    if db_path.exists():
        db_path.unlink()

    con = sqlite3.connect(db_path)
    try:
        con.execute("PRAGMA foreign_keys = ON;")
        con.executescript(sql_text)
        con.commit()
    finally:
        con.close()

    print(f"Created: {db_path}")


if __name__ == "__main__":
    main()

