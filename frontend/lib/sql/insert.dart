import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import 'base.dart';

const uuid = Uuid();

Future<void> insert({
  required String category,
  required int latency,
  required bool isError,
  DatabaseExecutor? db,
}) async {
  db ??= await BaseSqlite.open();

  await db.rawInsert("""
        INSERT INTO benchmark (
          id,
          category,
          latency,
          is_error
         ) VALUES (?, ?, ?, ?)
        """, [uuid.v4(), category, latency, isError ? 1 : 0]);
}
