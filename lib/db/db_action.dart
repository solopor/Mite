
abstract class DbAction {

  Future insert(String table, Map<String, dynamic> row);

  Future<int> queryRowCount(String table);

  Future<List<Map<String, dynamic>>> queryAllRows(String table);

  Future<int> update(String table, Map<String, dynamic> row);

  Future<int> delete(String table, int id);

}