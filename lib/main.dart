import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;

import 'package:mite/page_meeting_moring_list.dart';
import 'package:mite/page_meeting_evening_list.dart';
import 'package:mite/page_setting.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '米特',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MainPage(),
    );
  }

  
}

class MainPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _MainPageState();
  }
  
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  TabController tabController;
  int _selectIndex = 1;

  final List<String> titles = <String>[
    "晨会",
    "夕会",
    "设置"
  ];

  final List<Widget> pages = <Widget> [
    PageMeetingMoringList(),
    PageMeetingEveningList(),
    PageSetting()
  ];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
//        floatingActionButton: new FloatingActionButton(
//          elevation: 0.4,
//          highlightElevation: 0.1,
//          mini: false,
//          child: Icon(Icons.add),
//          onPressed: this._onAddClick,
//        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.wb_sunny), title: Text(this.titles[0])),
            BottomNavigationBarItem(icon: Icon(Icons.wb_cloudy), title: Text(this.titles[1])),
            BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text(this.titles[2])),
          ],
          fixedColor: Colors.red,
          onTap: _onItemChanged,
          currentIndex: _selectIndex,
        ),
        
        body: IndexedStack(
          index: _selectIndex,
          children: pages
        ),
    );
  }

  void _onItemChanged(int index) {
    setState(() {
      this._selectIndex = index;
    });
  }

//  void _onAddClick() {
//    Navigator.of(context).push(
//        new MaterialPageRoute(
//            builder: (context) {
//              return new PageMeetingMoringAdd();
//            }
//        )
//    );
//  }
}


