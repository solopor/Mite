import 'package:flutter/material.dart';
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
  final List<MeetingBean> _suggestions = <MeetingBean>[
    MeetingBean("2019年6月4日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
    MeetingBean("2019年6月3日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
    MeetingBean("2019年6月2日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
    MeetingBean("2019年6月1日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
    MeetingBean("2019年5月13日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
    MeetingBean("2019年5月12日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
    MeetingBean("2019年5月11日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
    MeetingBean("2019年5月10日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
    MeetingBean("2019年5月9日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
    MeetingBean("2019年5月8日", ["张大", "张二", "张三"], "今天完成了xxx任务，xxx进行中"),
  ]; //这个list应从数据库中拿出来的

  bool isShowDateTitle(int index) {
    //如果不这么做就从数据库里拿出数据时，就处理下作为Map吧
    if (index == 0) {
      return true;
    }
    MeetingBean currMeetingBean = _suggestions[index];
    MeetingBean lastMeetingBean = _suggestions[index - 1];

    String currDate = currMeetingBean.date
        .substring(0, currMeetingBean.date.indexOf('月') + 1);
    String lastDate = lastMeetingBean.date
        .substring(0, lastMeetingBean.date.indexOf('月') + 1);
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
          itemCount: _suggestions.length,
          itemBuilder: (context, index) {
            MeetingBean meetingBean = _suggestions[index];
            if (isShowDateTitle(index)) {
              return Column(
                children: <Widget>[
                  Text(
                    meetingBean.date
                        .substring(0, meetingBean.date.indexOf('月') + 1),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SingleMeetingRecordWdg(meetingBean, index.isOdd)
                ],
              );
            } else {
              return SingleMeetingRecordWdg(meetingBean, index.isOdd);
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
  MeetingBean meetingBean;
  bool showBgColor;

  SingleMeetingRecordWdg(this.meetingBean, this.showBgColor);

  BorderSide borderSide = BorderSide(width: 0.5, color: Color(0xffbbae8e));

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
    TextStyle(color: Color(0xff333333), fontSize: 14, letterSpacing: 1.5);
    return Container(
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
            '时间：' + meetingBean.date,
            style: textStyle,
          ),
          Text(
            '参会人员: ' + meetingBean.participants.toString(),
            style: textStyle,
          ),
          Container(
            height: 0.5,
            color: Color(0xff999999),
            margin: EdgeInsets.only(bottom: 8, top: 8),
          ),
          Text(
            '会议内容: \r\n' + meetingBean.content,
            style: textStyle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis, //显示不下时显示省略号
          )
        ],
      ),
    );
  }

}

class MeetingBean {
  String date;
  List<String> participants;
  String content;

  MeetingBean(this.date, this.participants, this.content);
}
