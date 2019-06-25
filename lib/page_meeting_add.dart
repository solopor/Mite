import 'package:flutter/material.dart';
import 'package:mite/db/db_action_impl.dart';
import 'package:mite/db/db_action.dart';
import 'package:mite/db/table/metting_record.dart';

//text: "客户第一 | 团结协作 | 重在执行 | 激情澎湃 | 积德行善",
// ignore: must_be_immutable
class PageMeetingAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PageMeetingAddState();
  }
}

class PageMeetingAddState extends State<PageMeetingAdd> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新增会议记录'),
      ),
      body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              //显式指定对齐方式为左对齐，排除对齐干扰
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MeetingContentInput(),
              ],
            ),
          )),
    );
  }
}

class MeetingContentInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MeetingContentInputState();
  }
}

class MeetingContentInputState extends State<MeetingContentInput> {
  var groupName;
  var memberName;
  var projectName;
  var workConent;
  var culture;
  var meetingType = "TYPE_MORING";
  var dateTime;
  final DbAction dbAction = new DbActionImpl();
  var result;

  @override
  void initState() {
    super.initState();
    dateTime = new DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 15, right: 15),
      child: Column(
        children: <Widget>[
          _buildMeetingType(),
          _buildTime(),
          _buildTeamName(),
          _buildMemberName(),
          _buildProjectName(),
          _buildWorkContent(),
          _buildCulture(),
          _buildSubmitBtn(context)
        ],
      ),
    );
  }

  _buildMeetingType() {
    return Row(
      children: <Widget>[
        Flexible(
          child: RadioListTile<String>(
            value: 'TYPE_MORING',
            title: Text('晨会'),
            groupValue: meetingType,
            onChanged: (value) {
              setState(() {
                meetingType = value;
              });
            },
          ),
        ),
        Flexible(
          child: RadioListTile<String>(
            value: 'TYPE_EVENING',
            title: Text('夕会'),
            groupValue: meetingType,
            onChanged: (value) {
              setState(() {
                meetingType = value;
              });
            },
          ),
        ),
      ],
    );
  }

  _buildTime() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              " 时间: ",
              textScaleFactor: 1.2,
            ),
            Text(
              dateTime.toString(),
              textScaleFactor: 1.2,
            ),
          ]),
    );
  }

  _buildTeamName() {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        icon: Icon(Icons.card_membership),
        labelText: '请输入你所在团队)',
      ),
      onChanged: getInputGroupName,
      autofocus: false,
    );
  }

  _buildMemberName() {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        icon: Icon(Icons.nature_people),
        labelText: '请输入成员名单)',
      ),
      onChanged: getInputMember,
      autofocus: false,
    );
  }

  _buildProjectName() {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        icon: Icon(Icons.print),
        labelText: '请输入你参与的项目名称)',
      ),
      onChanged: getInputProjectName,
      autofocus: false,
    );
  }

  _buildWorkContent() {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        icon: Icon(Icons.work),
        labelText: '请输入你详细的工作内容)',
      ),
      onChanged: getInputWorkContent,
      autofocus: false,
    );
  }

  _buildCulture() {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        icon: Icon(Icons.business),
        labelText: '请输入请输入企业文化)',
      ),
      onChanged: getInputWorkCulture,
      autofocus: false,
    );
  }

  _buildSubmitBtn(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new RaisedButton(
              onPressed: () {
                submit(context);
              },
              //通过控制 Text 的边距来控制控件的高度
              child: new Padding(
                padding: new EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                child: new Text("提交"),
              ),
              color: Colors.blue,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void submit(BuildContext context) async {
    String time = dateTime.toString().split(".")[0];

    if (meetingType == null || meetingType.length < 1) {
      showMsg(context, "请选择会议类型!");
      return;
    }

    if (time == null || time.length < 1) {
      showMsg(context, "获取时间失败!");
      return;
    }

    if (groupName == null || groupName.length < 1) {
      showMsg(context, "请输入团队名称!");
      return;
    }

    if (projectName == null || projectName.length < 1) {
      showMsg(context, "请输入项目名称!");
      return;
    }

    if (workConent == null || workConent.length < 1) {
      showMsg(context, "请输入工作内容!");
      return;
    }

    if (memberName == null || memberName.length < 1) {
      showMsg(context, "请输入成员名单!");
      return;
    }

    if (culture == null || culture.length < 1) {
      showMsg(context, "请输入企业文化!");
      return;
    }

    Map<String, dynamic> row = {
      MeetingRecord.columnGroupName: groupName,
      MeetingRecord.columnProjectName: projectName,
      MeetingRecord.columnDate: dateTime.toString().split(".")[0],
      MeetingRecord.columnWorkDetail: workConent,
      MeetingRecord.columnCulture: culture,
      MeetingRecord.columnMember: memberName
    };
    final id = await dbAction.insert(MeetingRecord.table, row);
    if (id > 0) {
      showMsg(context, "添加成功！");
    } else {
      showMsg(context, "添加失败！");
    }
  }

//
  ///获取团队名称
  void getInputGroupName(String value) {
    groupName = value;
  }

  ///获取项目名称
  void getInputProjectName(String value) {
    projectName = value;
  }

  ///获取详细的工作内容
  void getInputWorkContent(String value) {
    workConent = value;
  }

  ///获取企业文化
  void getInputWorkCulture(String value) {
    culture = value;
  }

  ///获取成员组成
  void getInputMember(String value) {
    memberName = value;
  }

  void showMsg(BuildContext context, String msg) {
    final snackBar = new SnackBar(
      content: new Text(msg),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 1),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

}
