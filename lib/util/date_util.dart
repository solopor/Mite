class DateUtil {
  test() {
    DateTime dateTime = DateTime.now();
    print('year =' +dateTime.year.toString() + ', month =' + dateTime.month.toString());
  }

  testLastYear() {
    DateTime dateNow = DateTime.now();
    DateTime lastYear = dateNow.subtract(Duration(days: 365));
    print('year =' +lastYear.year.toString() + ', month =' + lastYear.month.toString() 
      + ", day = " + lastYear.day.toString());
    print(dateNow.toString());

  }

  /*
   * 返回两个日期之间所有日期列表
   * @param startTime: 起始时间
   * @param endTime: 终止时间
   */
  List<String> getDaysBetweenTwoDate(String startTime, String endTime) {
    var dateList = <String>[];
    DateTime startDate = DateTime.tryParse(startTime);
    DateTime endDate = DateTime.tryParse(endTime);
    while(startDate.isBefore(endDate)) {
      String str = startDate.toString();
      dateList.add(str.substring(0, str.indexOf(" ")));
      // print(startDate.year.toString() + "-" + startDate.month.toString() + "-" + startDate.day.toString());
      startDate = startDate.add(Duration(days:1));
    }
    String endDateStr = endDate.toString();
    dateList.add(endDateStr.substring(0, endDateStr.indexOf(" ")));
    return dateList;
  }
}
