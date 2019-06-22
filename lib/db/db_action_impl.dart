import 'package:mite/db/db_action.dart';
import 'package:mite/db/database_hepler.dart';


class DbActionImpl extends DbAction {


  DatabaseHelper databaseHelper;

  DbActionImpl() {
    databaseHelper = DatabaseHelper.instance;
  }

  @override
  Future insert(String table, Map<String, dynamic> row) {
    return databaseHelper.insert(table, row);
  }

  @override
  Future<List<Map<String, dynamic>>> queryAllRows(String table) {
    return databaseHelper.queryAllRows(table);
  }

  @override
  Future<int> queryRowCount(String table) {
    return databaseHelper.queryRowCount(table);
  }

  @override
  Future<int> update(String table, Map<String, dynamic> row) {
    return databaseHelper.update(table , row);
  }

  Future<int> delete(String table, int id) {
    return databaseHelper.delete(table, id);
  }
  
}