import 'package:mite/db/db_action.dart';
import 'package:mite/db/database_hepler.dart';
import 'package:mite/db/table/metting_record.dart';

class DbActionImpl extends DbAction {
  DatabaseHelper _databaseHelper;

  static final List<DbListener> _listenerList = [];

  DbActionImpl() {
    _databaseHelper = DatabaseHelper.instance;
  }

  @override
  Future insert(String table, Map<String, dynamic> row) {
    return _databaseHelper.insert(table, row).then((obj) {
      notifyDataHasChanged();
      return obj;
    });
  }

  @override
  Future<List<Map<String, dynamic>>> queryAllRows(String table) {
    return _databaseHelper.queryAllRows(table);
  }

  @override
  Future<List<Map<String, dynamic>>> queryRowsByMeetingType(
      String table, String meetingType) {
    return _databaseHelper.queryRowsByMeetingType(table, meetingType);
  }

  @override
  Future<int> queryRowCount(String table) {
    return _databaseHelper.queryRowCount(table);
  }

  @override
  Future<int> update(String table, Map<String, dynamic> row) {
    return _databaseHelper.update(table, row).then((int value) {
      notifyDataHasChanged();
      return value;
    });
  }

  Future<int> delete(String table, int id) {
    return _databaseHelper.delete(table, id).then((int value) {
      notifyDataHasChanged();
      return value;
    });
  }

  static Future<List<MeetingRecord>> queryAllMeetingRecord(String table) async {
    return DbActionImpl().queryAllRows(table).then((List list) {
      List<MeetingRecord> result = [];
      list.forEach((mapObj) {
        //TODO:这里拿到的List最好按照Date排序；
        result.add(MeetingRecord(
          mapObj[MeetingRecord.columnMeetingType],
          mapObj[MeetingRecord.columnMember],
          mapObj[MeetingRecord.columnGroupName],
          mapObj[MeetingRecord.columnProjectName],
          mapObj[MeetingRecord.columnWorkDetail],
          mapObj[MeetingRecord.columnDate],
          mapObj[MeetingRecord.columnCulture],
        ));
      });
      return result;
    }, onError: (e) {
      return <MeetingRecord>[];
    });
  }



  static Future<List<MeetingRecord>> queryAllMeetingRecordByMeetingType(String table,String meetingType) async {
    return DbActionImpl().queryRowsByMeetingType(table,meetingType).then((List list) {
      List<MeetingRecord> result = [];
      list.forEach((mapObj) {
        result.add(MeetingRecord(
          mapObj[MeetingRecord.columnMeetingType],
          mapObj[MeetingRecord.columnMember],
          mapObj[MeetingRecord.columnGroupName],
          mapObj[MeetingRecord.columnProjectName],
          mapObj[MeetingRecord.columnWorkDetail],
          mapObj[MeetingRecord.columnDate],
          mapObj[MeetingRecord.columnCulture],
        ));
      });
      print("queryAllMeetingRecordByMeetingType:\n"+result.toString());
      return result;
    }, onError: (e) {
      return <MeetingRecord>[];
    });
  }


  @override
  static void addDbListener(DbListener dbListener) {
    _listenerList.add(dbListener);
  }

  @override
  void notifyDataHasChanged() {
    _listenerList.forEach((DbListener listener) {
      listener.notifyDataHasChanged();
    });
  }
}
