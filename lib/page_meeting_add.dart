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
  var meetingType = "MEETING_TYPE_MORING";
  var result;
  final DbAction dbAction = new DbActionImpl();

  TextEditingController  groupTextEditingController=TextEditingController();
  TextEditingController  memberTextEditingController=TextEditingController();
  TextEditingController  projectTextEditingController=TextEditingController();
  TextEditingController  workTextEditingController=TextEditingController();
  TextEditingController  cultureTextEditingController=TextEditingController();

  String date = DateTime.now().toString();

  @override
  void initState() {
    super.initState();
    _setDate(DateTime.now().toString());
  }

  void _setDate(String date) {
    print("dxt-" + date + " last:${this.date}");
    String str = date.toString();
    str = str.substring(0, str.indexOf(" "));
    setState(() {
      this.date = str;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 15, right: 15),
      child: Column(
        children: <Widget>[
          buildTimeWdg(date, _setDate),
          _buildMeetingType(),
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
            value: 'MEETING_TYPE_MORING',
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
            value: 'MEETING_TYPE_EVENING',
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

  _buildTeamName() {
    return TextField(
      keyboardType: TextInputType.text,
      controller: groupTextEditingController,
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
      controller: memberTextEditingController,
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
      controller: projectTextEditingController,
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
      controller: workTextEditingController,
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
      controller: cultureTextEditingController,
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

    if (meetingType == null || meetingType.length < 1) {
      showMsg(context, "请选择会议类型!");
      return;
    }

    if (date == null || date.length < 1) {
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
      MeetingRecord.columnDate: date,
      MeetingRecord.columnWorkDetail: workConent,
      MeetingRecord.columnCulture: culture,
      MeetingRecord.columnMember: memberName,
      MeetingRecord.columnMeetingType:meetingType,
    };
    final id = await dbAction.insert(MeetingRecord.table, row);
    if (id > 0) {
      showMsg(context, "添加成功！");
      clearInput();
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

  void clearInput() {
    groupTextEditingController.clear();
    memberTextEditingController.clear();
    projectTextEditingController.clear();
    workTextEditingController.clear();
    cultureTextEditingController.clear();

  }


}


class buildTimeWdg extends StatefulWidget {
  final String date;
  final Function changeDateFuc;

  buildTimeWdg(this.date, this.changeDateFuc);

  @override
  State<StatefulWidget> createState() {
    return TimeWdgState();
  }
}

class TimeWdgState extends State<buildTimeWdg> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () => _tapDateAction(context),
          child: Text(
            "${widget.date}",
            style: TextStyle(
                fontSize: 26,
                color: Colors.blue,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  _tapDateAction(BuildContext context) async {
    Locale locale = Localizations.localeOf(context);
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2014),
        lastDate: DateTime.now(),
        locale: locale)
        .then((DateTime dateTime) {
      if (dateTime != null) {
        widget.changeDateFuc(dateTime.toString());
      }
    });
  }
}