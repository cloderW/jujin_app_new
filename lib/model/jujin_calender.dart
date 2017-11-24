import 'dart:async';


class CalenderItem {
  // API properties

  String title;
  String stime;
  String country_cn;
  String idx_relevance;
  String previous_price;
  String surver_price;
  String actual_price;
  String affect;
  int type;
  String country;
  String area;
  String event_desc;
  String event_time;
  String importance;

  CalenderItem({
    this.title,
    this.stime,
    this.country_cn,
    this.idx_relevance,
    this.previous_price,
    this.surver_price,
    this.actual_price,
    this.affect,
    this.type,
    this.country,
    this.area,
    this.event_desc,
    this.event_time,
    this.importance
  });
}

class CalenderData {
  int success;
  List<CalenderItem> value;
  CalenderData(Map<String, dynamic> map) {
    this.success = map["success"];
    List<Map<String, dynamic>> list = map["value"];
    List<CalenderItem> values = new List();
    for (int i = 0; i < list.length; i++) {
      Map<String, dynamic> value = list[i];
      //数据
      CalenderItem calenderItem;
      if(value["type"]==1) {
        calenderItem = new CalenderItem(
          title:value["title"].toString(),
          stime:value["stime"].toString(),
          country_cn:value["country_cn"].toString(),
          idx_relevance:value["idx_relevance"].toString(),
          previous_price:value["previous_price"].toString(),
          surver_price:value["surver_price"].toString(),
          actual_price:value["actual_price"].toString(),
          affect:value["affect"].toString(),
          type:value["type"]
        );

      }else{
        calenderItem = new CalenderItem(
            country:value["country"].toString(),
            area:value["area"].toString(),
            event_desc:value["event_desc"].toString(),
            event_time:value["event_time"].toString(),
            importance:value["importance"].toString(),
            type:value["type"]
        );
      }
      values.add(calenderItem);
    }
    this.value = values;
  }
}

class Calender {

  final List<CalenderItem> calenderList;

  const Calender({this.calenderList});

  Calender.fromList(this.calenderList);

}

abstract class CalenderRepository {
  static final _cache = <String,Calender>{};
  // Abstract method to be defined in implementations
  Future<Calender> fetch(String date);
  Future<Calender> load(String date,
      [bool forceReload = false]) async {

    if (_cache.containsKey(date) && !forceReload) {
      return _cache[date];
    } else {
      final calender = await fetch(date);
      _cache[date] = calender;
      return calender;
    }
  }
}
