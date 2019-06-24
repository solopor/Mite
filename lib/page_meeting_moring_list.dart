import 'package:flutter/material.dart';
import 'package:mite/page_meeting_morning_add.dart';
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
    // TODO: implement createState
    return new PageAState();
  }
}

class PageAState extends State<WidgetA> {
  final List<String> _suggestions = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'G',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'V'
  ];

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('晨会记录'),
        actions: <Widget>[ //导航栏右侧菜单
          IconButton(icon: Icon(Icons.add),
              onPressed: this._onAddClick),

        ],
      ),
//      floatingActionButton: new FloatingActionButton(
//        elevation: 0.4,
//        highlightElevation: 0.1,
//        mini: false,
//        child: Icon(Icons.add),
//        onPressed: this._onAddClick,
//      ),
    );
  }

  List<String> generateWordPairs() {
    return _suggestions.take(10);
  }

  _buildRow(i) {
    return new ListTile(
      title: new Text(_suggestions[i], style: _biggerFont),
    );
  }

  void _onAddClick() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new PageMeetingMoringAdd();
    }));
  }
}
