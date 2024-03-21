import 'package:frontend/model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import 'base.dart';

const uuid = Uuid();

Future<Result> stat(
  String category, {
  DatabaseExecutor? db,
}) async {
  db ??= await BaseSqlite.open();

  List<Map<String, dynamic>> result;

  // compute duration from first and last item's created_at
  result = await db.query(
    'benchmark',
    columns: ['created_at'],
    where: 'category = ?',
    whereArgs: [category],
    orderBy: 'created_at ASC',
    limit: 1,
  );
  final first = result.first;

  result = await db.query(
    'benchmark',
    columns: ['created_at'],
    where: 'category = ?',
    whereArgs: [category],
    orderBy: 'created_at DESC',
    limit: 1,
  );
  final last = result.first;

  final duration = last['created_at'] - first['created_at'];

  // compute total errors
  result = await db.query(
    'benchmark',
    columns: ['COUNT(*)'],
    where: 'category = ? AND is_error = 1',
    whereArgs: [category],
  );
  final errors = result.first.values.first as int;

  // compute total requests
  result = await db.query(
    'benchmark',
    columns: ['COUNT(*)'],
    where: 'category = ? AND is_error = 0',
    whereArgs: [category],
  );
  final requests = result.first.values.first as int;

  // get average latency
  result = await db.query(
    'benchmark',
    columns: ['AVG(latency)'],
    where: 'category = ?',
    whereArgs: [category],
  );
  final latency = result.first.values.first.toInt();

  // get request per second
  final reqPerSec = (requests / (duration / 1000)).round();

  return Result(
    latency: latency,
    reqPerSec: reqPerSec,
    requests: requests,
    duration: duration,
    errors: errors,
  );
}
