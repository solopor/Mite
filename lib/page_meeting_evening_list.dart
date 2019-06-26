import 'package:flutter/material.dart';
import 'package:mite/db/db_action.dart';
import 'package:mite/db/db_action_impl.dart';
import 'package:mite/db/table/metting_record.dart';

class PageMeetingEveningList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Color(0xfff5f5f5),
      backgroundColor: Color(0xffffffff),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: TitleWdg(),
            ),
            Expanded(
              flex: 4,
              child: EveMeetingRecordWdg(),
            )
          ],
        ),
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

class EveMeetingRecordWdgState extends State<EveMeetingRecordWdg>
    implements DbListener {
  final List<MeetingRecord> _list = <MeetingRecord>[];
  String noDataPrompt = "努力拉取数据中 (｡ì _ í｡)";

  @override
  void initState() {
    super.initState();
    DbActionImpl.addDbListener(this);
    _getData();
  }


  void _getData() async {
    await DbActionImpl.queryAllMeetingRecordByMeetingType(
            MeetingRecord.table, "MEETING_TYPE_EVENING")
        .then((List<MeetingRecord> list) {
      setState(() {
        _list.removeRange(0, _list.length);

        if (list.length == 0) {
          noDataPrompt = "暂时没有数据诶 ╮(╯▽╰)╭";
        } else {
          _list.insertAll(0, list.reversed);
        }
      });
    }, onError: (e) => {print("-----> query data from db error")});
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
    return _list.length > 0
        ? ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context, index) {
              MeetingRecord meetingRecord = _list[index];
              if (_isShowDateTitle(index)) {
                return Column(
                  children: <Widget>[
                    Text(
                      meetingRecord.date
                          .substring(0, meetingRecord.date.lastIndexOf('-')),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.black38),
                    ),
                    RecordCardWdg(meetingRecord, index.isOdd)
                  ],
                );
              } else {
                return RecordCardWdg(meetingRecord, index.isOdd);
              }
            })
        : NoDataWdg(noDataPrompt);
  }

  @override
  notifyDataHasChanged() {
    _getData();
  }
}

class RecordCardWdg extends StatelessWidget {
  final MeetingRecord meetingRecord;
  final bool showBgColor;
  final BorderSide borderSide =
      BorderSide(width: 0.5, color: Color(0xffbbae8e));

  RecordCardWdg(this.meetingRecord, this.showBgColor);

  _responseTap() {
    //TODO:处理点击
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
//        padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
//            border: Border(
//                top: borderSide,
//                right: borderSide,
//                bottom: borderSide,
//                left: borderSide),
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
      child: Text(
        "时间: ${meetingRecord.date}\r\n参会人员: ${meetingRecord.member}",
        style: _textStyle,
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

class TitleWdg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("image/bg_title1.jpeg"),fit: BoxFit.fill),
      ),
//      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "夕会记录",
            style: TextStyle(fontSize: 26, color: Color(0xaa4290BE),fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.brightness_2,
            color: Color(0xaa4290BE),
            size: 50,
          ),
        ],
      ),
    );
  }
}
