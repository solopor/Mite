import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;

import 'package:mite/page_a.dart';
import 'package:mite/page_b.dart';
import 'package:mite/page_c.dart';
import 'package:mite/page_d.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '米特',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MainPage()
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
  ];

  final List<Widget> pages = <Widget> [
    PageA(),
    PageB()
  ];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
        floatingActionButton: new FloatingActionButton(
          elevation: 0.4,
          highlightElevation: 0.1,
          mini: false,
          child: Icon(Icons.add),
          onPressed: this._onAddClick,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text(this.titles[0])),
            BottomNavigationBarItem(icon: Icon(Icons.business), title: Text(this.titles[1])),
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

  void _onAddClick() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new PageD();
        }
      )
    );
  }
}


