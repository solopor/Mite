import 'package:flutter/material.dart';
import 'package:mite/db/db_action.dart';
import 'package:mite/db/db_action_impl.dart';
import 'package:mite/db/table/metting_record.dart';

class PageMeetingEveningList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: EveMeetingRecordWdg(),
      ),
    );
  }
}

class EveMeetingRecordWdg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EveMeetingRecordWdgState();
  }
}

class EveMeetingRecordWdgState extends State<EveMeetingRecordWdg> implements DbListener{
  final List<MeetingRecord> _list = <MeetingRecord>[
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名",
        "今天完成了xxx任务，xxx进行中", "2019-06-04", "企业文化"),
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名",
        "今天完成了xxx任务，xxx进行中", "2019-06-03", "企业文化"),
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名",
        "今天完成了xxx任务，xxx进行中", "2019-06-02", "企业文化"),
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名",
        "今天完成了xxx任务，xxx进行中", "2019-06-01", "企业文化"),
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名",
        "今天完成了xxx任务，xxx进行中", "2019-05-20", "企业文化"),
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名",
        "今天完成了xxx任务，xxx进行中", "2019-05-19", "企业文化"),
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名",
        "今天完成了xxx任务，xxx进行中", "2019-05-18", "企业文化"),
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名",
        "今天完成了xxx任务，xxx进行中", "2019-05-17", "企业文化"),
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名",
        "今天完成了xxx任务，xxx进行中", "2019-05-16", "企业文化"),
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名",
        "今天完成了xxx任务，xxx进行中", "2019-05-15", "企业文化")
  ];

  @override
  void initState(){
    DbActionImpl.addDbListener(this);
    _getData();
  }

  void _getData() async{
    await DbActionImpl.queryAllMeetingRecord(MeetingRecord.table)
        .then((List<MeetingRecord> list){
      setState(() {
        _list.removeRange(0, _list.length);
        _list.insertAll(0, list.reversed);
      });
    }, onError: (e)=>{print("-----> query data from db error")});
  }

  bool _isShowDateTitle(int index) {
    if (index == 0) {
      return true;
    }
    MeetingRecord currMeetingRecord = _list[index];
    MeetingRecord lastMeetingRecord = _list[index - 1];

    String currDate = currMeetingRecord.date
        .substring(0, currMeetingRecord.date.lastIndexOf('-'));
    String lastDate = lastMeetingRecord.date
        .substring(0, lastMeetingRecord.date.lastIndexOf('-'));
    if (currDate != lastDate) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        title: Text('夕会记录'),
      ),
      body: _list.length>0?ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            MeetingRecord meetingRecord = _list[index];
            if (_isShowDateTitle(index)) {
              return Column(
                children: <Widget>[
                  Text(
                    meetingRecord.date
                        .substring(0, meetingRecord.date.lastIndexOf('-')),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SingleMeetingRecordWdg(meetingRecord, index.isOdd)
                ],
              );
            } else {
              return SingleMeetingRecordWdg(meetingRecord, index.isOdd);
            }
          }):Text("no data"),
    );
  }

  @override
  notifyDataHasChanged() {
    _getData();
  }
}

class SingleMeetingRecordWdg extends StatelessWidget {
  MeetingRecord meetingRecord;
  bool showBgColor;

  SingleMeetingRecordWdg(this.meetingRecord, this.showBgColor);

  BorderSide borderSide = BorderSide(width: 0.5, color: Color(0xffbbae8e));

  responseTap() {
    //TODO:处理点击
    print("click");
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
        TextStyle(color: Color(0xff333333), fontSize: 14, letterSpacing: 1.5);
    return GestureDetector(
      onTap: responseTap,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
        decoration: BoxDecoration(
//          color: showBgColor ? Color(0xfff2f2f2) : Color(0xffffffff),
            color: Color(0xffffffff),
            border: Border(
                top: borderSide,
                right: borderSide,
                bottom: borderSide,
                left: borderSide),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '时间：' + meetingRecord.date,
              style: textStyle,
            ),
            Text(
              '参会人员: ' + meetingRecord.member,
              style: textStyle,
            ),
            Container(
              height: 0.5,
              color: Color(0xff999999),
              margin: EdgeInsets.only(bottom: 8, top: 8),
            ),
            Text(
              '会议内容: \r\n' + meetingRecord.workDetail,
              style: textStyle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis, //显示不下时显示省略号
            )
          ],
        ),
      ),
    );
  }
}
