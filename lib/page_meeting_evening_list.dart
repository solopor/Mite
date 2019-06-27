import 'package:flutter/material.dart';
import 'package:mite/db/db_action.dart';
import 'package:mite/db/db_action_impl.dart';
import 'package:mite/db/table/metting_record.dart';

class PageMeetingEveningList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PageMeetingEveningListState();
  }
}

class PageMeetingEveningListState extends State<PageMeetingEveningList>
    implements DbListener {
  String date = DateTime.now().toString();
  final List<MeetingRecord> _list = <MeetingRecord>[];
  String noDataPrompt = "努力拉取数据中 (｡ì _ í｡)";

  @override
  void initState() {
    super.initState();
    DbActionImpl.addDbListener(this);
    _setDate(DateTime.now().toString());
    _getRecordData();
  }

  void _setDate(String date) {
    print("dxt-" + date + " last:${this.date}");
    String str = date.toString();
    str = str.substring(0, str.indexOf(" "));
    setState(() {
      this.date = str;
    });
    _getRecordData();
  }

  void _getRecordData() async {
    await DbActionImpl.queryAllRowsByTypeAndDate(
            MeetingRecord.table, "MEETING_TYPE_EVENING", date)
        .then((List<MeetingRecord> list) {
      setState(() {
        _list.clear();
        if (list.length == 0) {
          noDataPrompt = "暂时没有数据诶 ╮(╯▽╰)╭";
        } else {
          _list.addAll(list.reversed);
        }
      });
    }, onError: (e) => {print("-----> query data from db error")});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage("image/bg_title1.jpeg"),
              fit: BoxFit.fitWidth),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: TimeWdg(date, _setDate),
            ),
            Expanded(
              flex: 4,
              child: EveMeetingRecWdg(noDataPrompt, _list),
            )
          ],
        ),
      ),
    );
  }

  @override
  notifyDataHasChanged() {
    _getRecordData();
  }
}

class EveMeetingRecWdg extends StatelessWidget {
  final List<MeetingRecord> _list = <MeetingRecord>[];
  final String noDataPrompt;

  EveMeetingRecWdg(this.noDataPrompt, List<MeetingRecord> list) {
    _list.clear();
    _list.addAll(list);
  }

  @override
  Widget build(BuildContext context) {
    return _list.length > 0
        ? ListView.builder(
            padding: EdgeInsets.only(top: 0),
            itemCount: _list.length,
            itemBuilder: (context, index) {
              MeetingRecord meetingRecord = _list[index];
              return RecordCardWdg(meetingRecord);
            })
        : NoDataWdg(noDataPrompt);
  }
}

class RecordCardWdg extends StatelessWidget {
  final MeetingRecord meetingRecord;
  final BorderSide borderSide =
      BorderSide(width: 0.5, color: Color(0xffbbae8e));

  RecordCardWdg(this.meetingRecord);

  _responseTap() {
    //TODO:处理点击, 可以跳转详情页
    print("click");
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
        TextStyle(color: Color(0xff333333), fontSize: 14, letterSpacing: 1.5);
    return GestureDetector(
      onTap: _responseTap,
      child: Container(
        margin: EdgeInsets.only(left: 12, top: 5, right: 12, bottom: 5),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                  color: Color(0xaa999999),
                  offset: Offset(0.5, 0.5),
                  blurRadius: 5)
            ],
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RecordCardTitleWdg(meetingRecord),
            Container(
              height: 0.5,
              color: Color(0xff999999),
              margin: EdgeInsets.only(left: 5, right: 180, top: 8),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, top: 8, bottom: 8),
              child: Text(
                '会议内容: \r\n' + meetingRecord.workDetail,
                style: textStyle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis, //显示不下时显示省略号
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecordCardTitleWdg extends StatelessWidget {
  final MeetingRecord meetingRecord;

  RecordCardTitleWdg(this.meetingRecord, {Key key}) : super(key: key);

  final TextStyle _textStyle =
      TextStyle(color: Color(0xff333333), fontSize: 14, letterSpacing: 1.5);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, top: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              "时间: ${meetingRecord.date}\r\n项目: ${meetingRecord.porjectName}\r\n参会人员: ${meetingRecord.member}",
              style: _textStyle,
            ),
          ),
        ],
      ),
    );
  }
}

class NoDataWdg extends StatelessWidget {
  final String content;

  NoDataWdg(this.content, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.notifications,
          color: Colors.amber,
        ),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            content,
            style: TextStyle(fontSize: 18, color: Color(0xff666666)),
          ),
        ),
      ],
    );
  }
}

class TimeWdg extends StatefulWidget {
  final String date;
  final Function changeDateFuc;

  TimeWdg(this.date, this.changeDateFuc);

  @override
  State<StatefulWidget> createState() {
    return TimeWdgState();
  }
}

class TimeWdgState extends State<TimeWdg> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TitleContentWdg(),
        GestureDetector(
          onTap: () => _tapDateAction(context),
          child: Text(
            "${widget.date}",
            style: TextStyle(
                fontSize: 26,
//                color: Color(0xaa4290BE),
                color: Colors.white,
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

class TitleContentWdg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "夕会记录",
          style: TextStyle(
              fontSize: 26,
//                  color: Color(0xaa4290BE),
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        Icon(
          Icons.brightness_2,
//              color: Color(0xaa4290BE),
          color: Colors.white,
          size: 50,
        ),
      ],
    );
  }
}
