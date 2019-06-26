import 'package:flutter/material.dart';
import 'package:mite/db/db_action.dart';
import 'package:mite/db/db_action_impl.dart';
import 'package:mite/db/table/metting_record.dart';

/*
 * db demo
 */
class PageSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'sqlite',
        theme: ThemeData(primaryColor: Colors.blue),
        home: DbTestPage());
  }
}

class DbTestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DbTestPageState();
  }
}

class DbTestPageState extends State<DbTestPage> {
  final DbAction dbAction = new DbActionImpl();
  var result;

  int day = 21;
  int month = 6;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('insert', style: TextStyle(fontSize: 20)),
              onPressed: () {
                _setDayAdd();
                _insert();
              },
            ),
            RaisedButton(
              child: Text('query', style: TextStyle(fontSize: 20)),
              onPressed: () {
                _query();
              },
            ),
            RaisedButton(
              child: Text('update', style: TextStyle(fontSize: 20)),
              onPressed: () {
                _update();
              },
            ),
            RaisedButton(
                child: Text('delete', style: TextStyle(fontSize: 20)),
                onPressed: () {
                  _setDayDel();
                  _delete();
                }),
            Text('$result', style: TextStyle(fontSize: 20, color: Colors.red))
          ],
        ),
      ),
    );
  }

  void _insert() async {
    Map<String, dynamic> row = {
      MeetingRecord.columnGroupName: '客户端',
      MeetingRecord.columnProjectName: '机器人八期',
      MeetingRecord.columnDate: '2019-0${month}-${day}',
      MeetingRecord.columnWorkDetail: '虚拟现实技术在项目中的使用，带给用户更加真实的体验感',
      MeetingRecord.columnCulture: '团建一致，不畏困难，突破技术难关',
      MeetingRecord.columnMember: '张三'
    };
    final id = await dbAction.insert(MeetingRecord.table, row);
    setState(() {
      result = 'insert result，id= $id';
    });
  }

  int _setDayAdd() {
    int tmpDay = 0;
    if (day ~/ 30 == 1) {
      _setMonthAdd();
      tmpDay = 10;
    } else {
      tmpDay = ++day;
    }

    setState(() {
      day = tmpDay;
    });
  }

  int _setMonthAdd() {
    int tmpMonth = 0;
    if (month ~/ 9 == 1) {
      tmpMonth = 1;
    } else {
      tmpMonth = ++month;
    }

    setState(() {
      month = tmpMonth;
    });
  }

  int _setDayDel() {
    int tmpDay = 0;
    if (day == 10) {
      _setMonthDel();
      tmpDay = 30;
    } else {
      tmpDay = --day;
    }

    setState(() {
      day = tmpDay;
    });
  }

  int _setMonthDel() {
    int tmpMonth = 0;
    if (month == 1) {
      //应该处理年
      tmpMonth = 9;
    } else {
      tmpMonth = --month;
    }
    setState(() {
      month = tmpMonth;
    });
  }

  void _query() async {
    final allRows = await dbAction.queryAllRows(MeetingRecord.table);
    var temp = 'query result';
    allRows.forEach((row) => {temp += row[MeetingRecord.columnProjectName]});
    setState(() {
      result = 'query result= $temp';
    });
  }

  void _update() async {
    Map<String, dynamic> row = {
      MeetingRecord.columnId: 1,
      MeetingRecord.columnMember: 'Mary',
      MeetingRecord.columnCulture: '1838283821838283828382883828382'
    };
    final rowsAffected = await dbAction.update(MeetingRecord.table, row);
    setState(() {
      result = 'update result= $rowsAffected';
    });
  }

  void _delete() async {
    final id = await dbAction.queryRowCount(MeetingRecord.table);
    final rowsDeleted = await dbAction.delete(MeetingRecord.table, id);
    setState(() {
      result = 'deleter rowsDeleted= $rowsDeleted';
    });
  }
}
