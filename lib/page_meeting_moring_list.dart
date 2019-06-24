import 'package:flutter/material.dart';
import 'package:mite/db/db_action_impl.dart';
import 'package:mite/morning_metting/date_choose.dart';
import 'package:mite/morning_metting/title.dart';

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

class PageAState extends State<WidgetA> {

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
      )
    );
        
  }

  onDateChange(String date) {

  }

  Widget _getMettingDetail() {
    return new Expanded(
      child: new ListView.separated(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            padding: EdgeInsets.only(left:10, right: 10, top: 10, bottom: 10),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    Image.asset("image/ground_touxiang.png",
                        width: 45, height: 45),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 0, left: 5),
                            child: Text(
                              "张三",
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
                                    "项目:",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 180, 201, 157),
                                        fontSize: 14),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "主客",
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
                    "明细:  机器人bug fix， 私人医生用例评审 ",
                    style: TextStyle(
                      color:Color.fromARGB(255, 102, 102, 102)
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(color: Colors.black12,);
        },
      ),
    );
  }
}
