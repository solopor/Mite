import 'package:flutter/material.dart';

class TitleView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        height: 60,
        color: Colors.blue,
        child: Center(
          child: Text('客户端团队', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal)),
        )
      ),
    );
  }
  
}