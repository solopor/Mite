
abstract class DbAction {
  Future insert(String table, Map<String, dynamic> row);

  Future<int> queryRowCount(String table);

  Future<List<Map<String, dynamic>>> queryAllRows(String table);

  Future<int> update(String table, Map<String, dynamic> row);

  Future<int> delete(String table, int id);

  static void addDbListener(DbListener dbListener){}

  void notifyDataHasChanged();
}

class DbListener{
  //TODO:这里的数据变化可以细化，比如是什么操作导致的变化，这样另一边更新数据时不用对所有数据进行操作
  notifyDataHasChanged(){}
}