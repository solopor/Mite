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
    print("db-path:------>" + path);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${MeetingRecord.table}(
        ${MeetingRecord.columnId} INTEGER PRIMARY KEY,
        ${MeetingRecord.columnMeetingType} TEXT NOT NULL,
        ${MeetingRecord.columnMember} TEXT NOT NULL,
        ${MeetingRecord.columnGroupName} TEXT NOT NULL,
        ${MeetingRecord.columnCulture} TEXT ,
        ${MeetingRecord.columnDate} TEXT NOT NULL,
        ${MeetingRecord.columnProjectName} TEXT NOT NULL,
        ${MeetingRecord.columnWorkDetail} TEXT NOT NULL
      )
      ''');
  }

  Future insert(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<int> queryRowCount(String table) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryRowsByMeetingType(
      String table, String meetingType) async {
    Database db = await instance.database;
    print("sql---> query: "+'SELECT * FROM $table where meetingType= ' '\'$meetingType' '\'');
    return await db.rawQuery(
        'SELECT * FROM $table where meetingType= ' '\'$meetingType' '\'');
  }

  Future<List<Map<String, dynamic>>> queryRowsByTypeAndDate(
      String table, String meetingType, String date) async {
    Database db = await instance.database;
    print("sql---> query: "+'SELECT * FROM $table where meetingType=\'$meetingType\' and date like \'$date%\'');
    return await db.rawQuery(
        'SELECT * FROM $table where meetingType=\'$meetingType\' and date like \'$date%\'');
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
