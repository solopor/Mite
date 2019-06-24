import 'package:flutter/material.dart';
import 'package:mite/db/table/metting_record.dart';
import 'package:mite/page_meeting_evening_add.dart';
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

class EveMeetingRecordWdgState extends State<EveMeetingRecordWdg> {
  final List<MeetingRecord> _list = <MeetingRecord>[
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名", "今天完成了xxx任务，xxx进行中", "2019-6-4", "企业文化"),
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名", "今天完成了xxx任务，xxx进行中", "2019-6-3", "企业文化"),
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名", "今天完成了xxx任务，xxx进行中", "2019-6-2", "企业文化"),
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名", "今天完成了xxx任务，xxx进行中", "2019-6-1", "企业文化"),
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名", "今天完成了xxx任务，xxx进行中", "2019-5-20", "企业文化"),
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名", "今天完成了xxx任务，xxx进行中", "2019-5-19", "企业文化"),
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名", "今天完成了xxx任务，xxx进行中", "2019-5-18", "企业文化"),
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名", "今天完成了xxx任务，xxx进行中", "2019-5-17", "企业文化"),
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名", "今天完成了xxx任务，xxx进行中", "2019-5-16", "企业文化"),
    MeetingRecord(["张大", "张二", "张三"].toString(), "客户端团队", "项目名", "今天完成了xxx任务，xxx进行中", "2019-5-15", "企业文化")
  ];

//  final List<MeetingBean> _suggestions = <MeetingBean>[
//    MeetingBean("2019年6月4日", ["张大", "张二", "张三"], ""),
//    MeetingBean("2019年6月3日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
//    MeetingBean("2019年6月2日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
//    MeetingBean("2019年6月1日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
//    MeetingBean("2019年5月13日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
//    MeetingBean("2019年5月12日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
//    MeetingBean("2019年5月11日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
//    MeetingBean("2019年5月10日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
//    MeetingBean("2019年5月9日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
//    MeetingBean("2019年5月8日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
//  ]; //这个list应从数据库中拿出来的

  bool _isShowDateTitle(int index) {
    //如果不这么做就从数据库里拿出数据时，就处理下作为Map吧
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

//  _getDataFromDB() async{
//      final allRows = await DbActionImpl.queryAllRows(MettingRecord.table);//数据库对外调用改下
//      var temp = 'query result';
//      allRows.forEach((row) => {
//        temp += row[MettingRecord.columnProjectName]
//      });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        title: Text('夕会记录'),
        actions: <Widget>[ //导航栏右侧菜单
          IconButton(icon: Icon(Icons.add), onPressed: this._onAddClick),
        ],
      ),
//      floatingActionButton: new FloatingActionButton(
//        elevation: 0.4,
//        highlightElevation: 0.1,
//        mini: false,
//        child: Icon(Icons.add),
//        onPressed: this._onAddClick,
//      ),
      body: ListView.builder(
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
          }),
    );
  }

  void _onAddClick() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new PageMeetingEveningAdd();
    }));
  }
}

class SingleMeetingRecordWdg extends StatelessWidget {
  MeetingRecord meetingRecord;
  bool showBgColor;

  SingleMeetingRecordWdg(this.meetingRecord, this.showBgColor);

  BorderSide borderSide = BorderSide(width: 0.5, color: Color(0xffbbae8e));

  responseTap(){
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

//class MeetingBean {
//  String date;
//  List<String> participants;
//  String content;
//
//  MeetingBean(this.date, this.participants, this.content);
//}
