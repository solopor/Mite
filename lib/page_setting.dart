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
  var result = "操作结果:";

  int i = 0;
  List<String> dateList = <String>[
    "2019-06-24",
    "2019-06-25",
    "2019-06-26",
    "2019-06-27",
    "2019-06-28"
  ];
  List<String> groupList = <String>[
    "技术保障团队",
    "平台技术团队",
    "测试中心团队",
    "医学技术团队",
    "运维中心团队"
  ];
  List<String> memberList = <String>[
    "王强",
    "赵三",
    "李晓",
    "陈岚",
    "李耳"
  ];
  List<String> projectList = <String>["一分钟诊所", "主客", "工作台", "智能药柜", "机器人"];
  List<String> workList = <String>[
    "防止单方随意：由于过宽过窄都不利，而“不宽不窄”难以把握，有的用人单位于是在劳动合同中约定“用人单位可根据实际生产经营震置、，对劳动者的工作岗位进行调整’’之类的条款，这种条款实际上是赋予用人单位可以单方随意调整劳动者工作岗位的权利，也就是排除了劳动者协商变更劳动合同的权利，根据《劳动合同法》第二十六条之规定，这样的条款无效。",
    "工作内容是指劳动者具体从事什么种类或内容的劳动，是劳动合同确定劳动者应当履行劳动义务的主要内容，包括劳动者从事劳动的工种、岗位、工作范围、工作任务、工作职责、劳动定额、质量标准等。工作内容条款是劳动合同的核心条款之一。",
    "它是用人单位聘用劳动者的目的，也是劳动者取得劳动报酬的缘由。该条款的约定应当明确具体，便于劳动者判断自己是否胜任该工作，是否愿意从事该工作，也便于双方遵照执行。",
    "工作地点是指劳动者从事劳动合同约定工作的具体地理位置，也就是劳动合同的履行地。工作地点关系到劳动者的工作环境、生活环境和劳动者的就业选择，与劳动者的切身利益直接相关。工作地点既是用人单位在用工前应当告知劳动者的信息之一，又是劳动合同的必备条款，也是劳动合同法新增加的条款。",
    "恰当约定工作内容：工作内容条款是劳动合同确定劳动者应当履行劳动义务的主要条款，而且与用人单位的用工管理权密切相关。新法强调劳动合同书面化，即劳动合同的签订、变更都要经双方协商一致并书面化。与此同时，劳动合同法为了杜绝用人单位利用强势地位以书面合同条款的约定排除劳动者权利，该法第二十六条明确规定“用人单位免除自己的法定责任、排除劳动权利的”条款无效。"
  ];
  List<String> cultureList = <String>[
    "周密策划，科学管理，忠于设计，精心施工。",
    "坚持团结稳定，齐心协力干事业。",
    "克服困难，精心施工，优质、安全、准点完成工程建设任务！",
    "树立“下道工序就是用户”的思想，讲求职业道德和职业责任！",
    "你投入了心血、汗水、智慧，工程回报你安全、优质、效益！"
  ];

  @override
  void initState() {
    super.initState();
  }

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
//                  _setDayAdd();
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
//                  _setDayDel();
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

    int index = i % 5;
    Map<String, dynamic> row = {
      MeetingRecord.columnGroupName: groupList[index],
      MeetingRecord.columnMeetingType:
          i % 2 == 0 ? 'MEETING_TYPE_EVENING' : "MEETING_TYPE_MORNING",
      MeetingRecord.columnProjectName: projectList[index],
      MeetingRecord.columnDate: dateList[index],
      MeetingRecord.columnWorkDetail: workList[index],
      MeetingRecord.columnCulture: cultureList[index],
      MeetingRecord.columnMember: memberList[index]
    };
    final id = await dbAction.insert(MeetingRecord.table, row);
    setState(() {
      result = 'insert resultr:  id= $id';
    });
  }

//  int _setDayAdd() {
//    int tmpDay = 0;
//    if (day ~/ 30 == 1) {
//      _setMonthAdd();
//      tmpDay = 10;
//    } else {
//      tmpDay = ++day;
//    }
//
//    setState(() {
//      day = tmpDay;
//    });
//  }
//
//  int _setMonthAdd() {
//    int tmpMonth = 0;
//    if (month ~/ 9 == 1) {
//      tmpMonth = 1;
//    } else {
//      tmpMonth = ++month;
//    }
//
//    setState(() {
//      month = tmpMonth;
//    });
//  }
//
//  int _setDayDel() {
//    int tmpDay = 0;
//    if (day == 10) {
//      _setMonthDel();
//      tmpDay = 30;
//    } else {
//      tmpDay = --day;
//    }
//
//    setState(() {
//      day = tmpDay;
//    });
//  }
//
//  int _setMonthDel() {
//    int tmpMonth = 0;
//    if (month == 1) {
//      //应该处理年
//      tmpMonth = 9;
//    } else {
//      tmpMonth = --month;
//    }
//    setState(() {
//      month = tmpMonth;
//    });
//  }

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
