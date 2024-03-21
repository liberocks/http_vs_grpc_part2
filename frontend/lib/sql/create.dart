import 'package:sqflite/sqflite.dart';

import 'base.dart';

Future<void> create(DatabaseExecutor? db) async {
  db ??= await BaseSqlite.open();

  await db.execute(
    """
      CREATE TABLE IF NOT EXISTS benchmark (
        id TEXT PRIMARY KEY,
        category TEXT,
        latency INTEGER,
        is_error INTEGER,
        created_at INTEGER DEFAULT (CAST((julianday('now') - 2440587.5)*86400000 AS INTEGER))
      );
      """,
  );
}
