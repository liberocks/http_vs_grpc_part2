import 'package:sqflite/sqflite.dart';

import 'base.dart';

Future<void> reset(DatabaseExecutor? db) async {
  db ??= await BaseSqlite.open();

  await db.delete("benchmark");
}
