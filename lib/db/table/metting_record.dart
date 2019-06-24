import 'package:flutter/material.dart';

/*
 * 会议纪要
 */
class MeetingRecord {

  static final String table = 'mettingRecord';

  static final String columnId = '_id';

  static final String columnGroupName = 'groupName';//团队名

  static final String columnProjectName = 'projectName';//项目名

  static final String columnWorkDetail = 'workDetail';//工作详细

  static final String columnDate = 'date';//日期

  static final String columnCulture = 'culture';//企业文化

  static final String columnMember = 'member';//成员

  int id;
  String groupName;
  String porjectName;
  String workDetail;
  String date;
  String culture;
  String member;

  MeetingRecord(this.member, this.groupName, this.porjectName, this.workDetail, this.date, this.culture);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      columnId: id,
      columnMember: member,
      columnGroupName: groupName,
      columnProjectName: porjectName,
      columnWorkDetail: workDetail,
      columnDate: date,
      columnCulture: culture
    };
    return map;
  }
  MeetingRecord.fromMap(Map<String,dynamic> map) {
    groupName = map[columnGroupName];
    porjectName = map[columnProjectName];
    workDetail = map[columnWorkDetail];
    date = map[columnDate];
    culture = map[columnCulture];
    member = map[columnMember];
    id = map[columnId];
  }
   
}