import 'dart:io';

import 'package:frontend/utils/utils.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class BaseSqlite {
  static Future<Database> open() async {
    final Directory tmpDir = await getApplicationDocumentsDirectory();

    final String path = join(tmpDir.path, 'benchmark.db');

    return await openDatabase(
      path,
      version: 2,
    );
  }

  static Future<void> close(Database db) async {
    await db.close();
  }

  static Future<void> delete() async {
    final Directory tmpDir = await getApplicationDocumentsDirectory();

    final String path = join(tmpDir.path, 'myaria.db');
    await deleteDatabase(path);
  }

  static Future<void> runTransactions(
    List<Function(DatabaseExecutor)> queries,
  ) async {
    try {
      final db = await BaseSqlite.open();

      await db.transaction((txn) async {
        for (final query in queries) {
          await query(txn);
        }
      });
    } catch (e) {
      logDebug('onError: sqlite $e', level: Level.error);
    }
  }
}
