import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:mite/db/table/metting_record.dart';

class DatabaseHelper {
  
  static final _databseName = "Mite.db";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databseName);
    return await openDatabase(path, 
      version: _databaseVersion, 
      onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${MettingRecord.table}(
        ${MettingRecord.columnId} INTEGER PRIMARY KEY,
        ${MettingRecord.columnMember} TEXT NOT NULL,
        ${MettingRecord.columnGroupName} TEXT NOT NULL,
        ${MettingRecord.columnCulture} TEXT ,
        ${MettingRecord.columnDate} TEXT NOT NULL,
        ${MettingRecord.columnProjectName} TEXT NOT NULL,
        ${MettingRecord.columnWorkDetail} TEXT NOT NULL
      )
      ''');
  }

  Future insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<int> queryRowCount(String table) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> update(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['_id'];
    return await db.update(table, row, where: '_id = ?', whereArgs: [id]);
  }

  Future<int> delete(String table, int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '_id = ?', whereArgs: [id]);
  }
}