import 'package:flutter/material.dart';

class PageB extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PageB',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Center(
        child: new Text('PageB'),
      )
    );
  }

  
}