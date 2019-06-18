import 'package:flutter/material.dart';

class PageC extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PageC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Center(
        child: new Text('PageC'),
      )
    );
  }

  
}