import 'dart:async';
import 'package:dentisttry/Model/model.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

abstract class DB {
  static Database _db;

  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) {
      return;
    }

    try {
      var databasesPath = await getDatabasesPath();
      String _path = p.join(databasesPath, 'crud.dental');
      _db = await openDatabase(_path, version: _version, onCreate: onCreate);
    } catch (ex) {
      print(ex);
    }
  }

  static void onCreate(Database dental, int version) async {
    await dental.execute(
        'CREATE TABLE dental_info (id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING, categoryId INTEGER, email STRING, phone REAL, date String)');
    await dental.execute(
        'CREATE TABLE dental_type (id INTEGER PRIMARY KEY AUTOINCREMENT, categoryName STRING)');
    await dental.execute(
        "INSERT INTO dental_type (categoryName) VALUES ('Scaling and Polishing'), ('Crown and Caps'), ('Filling and Repair'),  ('Braces');");
  }

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      _db.query(table);

  static Future<int> insert(String table, Model model) async =>
      await _db.insert(table, model.toMap());

  static Future<int> update(String table, Model model) async => await _db
      .update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

  static Future<int> delete(String table, Model model) async =>
      await _db.delete(table, where: 'id = ?', whereArgs: [model.id]);

  static Future<Batch> batch() async => _db.batch();
}
