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
      home: new Scaffold(
          appBar: AppBar(
            title: Text('数据模拟'),
          ),
          backgroundColor: Colors.transparent,
          body: DbTestPage()),
      debugShowCheckedModeBanner: false,
    );
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
  var result="操作结果:";

  int day = 21;
  int month = 6;

  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 15, right: 15),
      child: Column(
        children: <Widget>[
          _buildSubmitBtn(context),
          buildLine(),
          _buildResult()
        ],
      ),
    );
  }

  _buildSubmitBtn(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(
                onPressed: () {
                  _setDayAdd();
                  _insert();
                },
                //通过控制 Text 的边距来控制控件的高度
                child: new Padding(
                  padding: new EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                  child: new Text("插入一条数据"),
                ),
                color: Colors.blue,
                textColor: Colors.white,
              ),
              new RaisedButton(
                onPressed: () {
                  _query();
                },

                //通过控制 Text 的边距来控制控件的高度
                child: new Padding(
                  padding: new EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                  child: new Text("查询所有记录"),
                ),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(
                onPressed: () {
                  _update();
                },
                //通过控制 Text 的边距来控制控件的高度
                child: new Padding(
                  padding: new EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                  child: new Text("修改一条记录"),
                ),
                color: Colors.blue,
                textColor: Colors.white,
              ),
              new RaisedButton(
                onPressed: () {
                  _setDayDel();
                  _delete();
                },
                //通过控制 Text 的边距来控制控件的高度
                child: new Padding(
                  padding: new EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                  child: new Text("删除一条记录"),
                ),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }

  void _insert() async {
    i++;
    Map<String, dynamic> row = {
      MeetingRecord.columnGroupName: '客户端',
      MeetingRecord.columnMeetingType:
          i % 2 == 0 ? 'MEETING_TYPE_EVENING' : "MEETING_TYPE_MORNING",
      MeetingRecord.columnProjectName: '机器人八期',
      MeetingRecord.columnDate: '2019-0${month}-${day}',
      MeetingRecord.columnWorkDetail: '虚拟现实技术在项目中的使用，带给用户更加真实的体验感',
      MeetingRecord.columnCulture: '团建一致，不畏困难，突破技术难关',
      MeetingRecord.columnMember: '张三'
    };
    final id = await dbAction.insert(MeetingRecord.table, row);
    setState(() {
      result = 'insert resultr:  id= $id';
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
//    print("sql---> query: "+'SELECT * FROM $table where meetingType= ' '\'$meetingType' '\'');

    final allRows = await dbAction.queryRowsByMeetingType(
        MeetingRecord.table, "MEETING_TYPE_EVENING");
    var temp = 'query result: ';
    allRows.forEach((row) => {temp += row[MeetingRecord.columnProjectName]});
    setState(() {
      result = '$temp';
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
      result = 'deleter rowsDeleted result:  $rowsDeleted';
    });
  }

  buildLine() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
            width: 1.0 / MediaQuery.of(context).devicePixelRatio,
            color: Colors.grey.withOpacity(0.5)),
      ),
    );
  }

  _buildResult() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  result,
                  style: TextStyle(color: Colors.blue),
                )),
          ),
        ],
      ),
    );
  }
}
