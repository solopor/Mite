import 'package:flutter/material.dart';

import 'package:mite/db/table/metting_record.dart';
import 'package:mite/db/db_action_impl.dart';
import 'package:mite/db/db_action.dart';

/*
 * db demo
 */
class PageSetting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sqlite',
      theme:  ThemeData(
        primaryColor: Colors.blue
      ),
      home: DbTestPage()
    );
  }
  
}

class DbTestPage extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return new DbTestPageState();
  }
}

class DbTestPageState extends State<DbTestPage> {
  final DbAction dbAction= new DbActionImpl();
  var result;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('insert', style: TextStyle(fontSize: 20)),
              onPressed: (){_insert();},
            ),
            RaisedButton(
              child: Text('query', style: TextStyle(fontSize: 20)),
              onPressed: (){_query();},
            ),
            RaisedButton(
              child: Text('update', style: TextStyle(fontSize: 20)),
              onPressed: (){_update();},
            ),
            RaisedButton(
              child: Text('delete', style: TextStyle(fontSize: 20)),
              onPressed: (){_delete();}
            ),
            Text('$result', style: TextStyle(fontSize: 20, color: Colors.red))
              
          ],
        ),
      ),
    );
  }

  void _insert() async {
    Map<String, dynamic> row = {
      MettingRecord.columnGroupName: '客户端',
      MettingRecord.columnProjectName: '机器人八期',
      MettingRecord.columnDate: '2019-06-21',
      MettingRecord.columnWorkDetail:'虚拟现实技术在项目中的使用，带给用户更加真实的体验感',
      MettingRecord.columnCulture:'团建一致，不畏困难，突破技术难关',
      MettingRecord.columnMember: '张三'
    };
    final id = await dbAction.insert(MettingRecord.table, row);
    setState(() {
      result = 'insert result，id= $id';
    });
  }

  void _query() async {
    final allRows = await dbAction.queryAllRows(MettingRecord.table);
    var temp = 'query result';
    allRows.forEach((row) => {
      temp += row[MettingRecord.columnProjectName]
    });
    setState(() {
        result = 'query result= $temp';
      });
  }

  void _update() async {
    Map<String, dynamic> row = {
      MettingRecord.columnId   : 1,
      MettingRecord.columnMember : 'Mary',
      MettingRecord.columnCulture  : '1838283821838283828382883828382'
    };
    final rowsAffected = await dbAction.update(MettingRecord.table, row);
    setState(() {
        result = 'update result= $rowsAffected';
      });
  }

  void _delete() async {
     final id = await dbAction.queryRowCount(MettingRecord.table);
    final rowsDeleted = await dbAction.delete(MettingRecord.table, id);
     setState(() {
        result = 'deleter rowsDeleted= $rowsDeleted';
      });
  }

}