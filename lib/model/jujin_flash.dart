import 'dart:async';

enum StoryType { top }


class FlashItem {
  // API properties
  int id;
  String publish_time;
  int importance;
  String source_id;
  String body;
  String created_at;
  String updated_at;
  String source_site;

  FlashItem({
    this.id,
    this.publish_time,
    this.importance,
    this.source_id,
    this.body,
    this.created_at,
    this.updated_at,
    this.source_site,
  });
}

class FlashData {
  int success;
  List<FlashItem> value;
  FlashData(Map<String, dynamic> map) {
    this.success = map["success"];
    List<Map<String, dynamic>> list = map["value"];
    List<FlashItem> values = new List();
    for (int i = 0; i < list.length; i++) {
      Map<String, dynamic> value = list[i];
      FlashItem flashItem = new FlashItem(id: value["id"],body: value["body"],
          source_site: value["source_site"], publish_time: value["publish_time"]);
      values.add(flashItem);
    }
    this.value = values;
  }
}

class Flash {

  final List<FlashItem> flashList;

  const Flash({this.flashList});

  Flash.fromList(this.flashList);

}

abstract class FlashRepository {
  static final _cache = <String,Flash>{};
  // Abstract method to be defined in implementations
  Future<Flash> fetch(String page,String num);
  Future<Flash> load(String page,String num,
      [bool forceReload = false]) async {

    if (_cache.containsKey(page+","+num) && !forceReload) {
      return _cache[page+","+num];
    } else {
      final hnStories = await fetch(page,num);
      _cache[page+","+num] = hnStories;
      return hnStories;
    }
  }
}
