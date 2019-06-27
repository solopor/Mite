import 'package:flutter/material.dart';
import 'package:mite/db/db_action_impl.dart';
import 'package:mite/morning_metting/date_choose.dart';
import 'package:mite/morning_metting/title.dart';
import 'package:mite/db/db_action.dart';
import 'package:mite/db/db_action_impl.dart';
import 'package:mite/db/table/metting_record.dart';

class PageMeetingMoringList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new WidgetA(),
    );
  }
}

class WidgetA extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PageAState();
  }
}

class PageAState extends State<WidgetA> implements DbListener {
  final List<MeetingRecord> _list = <MeetingRecord>[];
  String date = DateTime.now().toString();
  String noDataPrompt = "努力拉取数据中 (｡ì _ í｡)";
  List<String> images = <String>[
    "image/icon_1.png",
    "image/icon_2.png",
    "image/icon_3.png",
    "image/icon_4.png",
    "image/icon_5.png",
    "image/icon_6.png",
    "image/icon_7.png"
  ];

  @override
  void initState() {
    super.initState();
    _setDate(DateTime.now().toString());
    DbActionImpl.addDbListener(this);
    _getData();
  }


  void _setDate(String date) {
    print("dxt-" + date + " last:${this.date}");
    String str = date.toString();
    str = str.substring(0, str.indexOf(" "));
    setState(() {
      this.date = str;
    });
    _getData();
  }


  void _getData() async {
    await DbActionImpl.queryAllRowsByTypeAndDate(
            MeetingRecord.table, "MEETING_TYPE_MORNING",date)
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

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: new Column(
          children: <Widget>[
            TitleView(),
            CustomeDateWidget(callback: (date) => onDateChange(date)),
            _getMettingDetail()
          ],
        ));
  }

  onDateChange(String date) {
    this.date=date;
    _getData();
  }

  Widget _getMettingDetail() {
    return _list.length > 0
        ? new Expanded(
            child: new ListView.separated(
              padding: EdgeInsets.only(top: 0),
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int index) {
                MeetingRecord meetingRecord = _list[index];

                return new Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          Image.asset(images[index % 7], width: 45, height: 45),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 0, left: 5),
                                  child: Text(
                                    meetingRecord.member,
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 51, 51, 51),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 0, left: 5),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          meetingRecord.projectName,
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 180, 201, 157),
                                              fontSize: 14),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            meetingRecord.groupName,
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 180, 201, 157),
                                                fontSize: 14),
                                          ),
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "工作内容: " + meetingRecord.workDetail,
                          style: TextStyle(
                              color: Color.fromARGB(255, 102, 102, 102)),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.black12,
                );
              },
            ),
          )
        : NoDataWdg(noDataPrompt);
  }

  @override
  notifyDataHasChanged() {
    _getData();
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
