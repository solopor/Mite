import 'package:flutter/material.dart';

class PageA extends StatelessWidget {

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
  'A', 'B','C', 'D','E', 'F','G', 'H','I', 'G','K', 'L','M', 'N','O', 'P','Q', 'R','S', 'T','V'
];

final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('sqfite'),),
    );
        
  }

  List<String> generateWordPairs() {
    return _suggestions.take(10);
  }

  _buildRow(i) {
    return new ListTile(
      title: new Text(
        _suggestions[i],
        style: _biggerFont
      ),
    );
  }
}
