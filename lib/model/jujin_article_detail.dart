import 'dart:async';


class ArticleDetailItem {
  // API properties
  int id;
  String title;
  String created;
  String metadesc;
  String introtext;
  String metakey;
  String author;

  ArticleDetailItem({
    this.id,
    this.title,
    this.introtext,
    this.metadesc,
    this.metakey,
    this.author,
    this.created,
  });
}

class ArticleDetailData {
  int success;
  ArticleDetailItem  value;
  ArticleDetailData (Map<String, dynamic> map) {
    this.success = map["success"];
    Map<String, dynamic> vauleMap = map["value"];

    value=new ArticleDetailItem(title: vauleMap["title"],introtext:vauleMap["introtext"]);
  }
}

class ArticleDetail {

  ArticleDetailItem articleDetail;

  ArticleDetail({this.articleDetail});

  ArticleDetail.fromMap(this.articleDetail);

}

abstract class ArticleDetailRepository {
  static final _cache = <String,ArticleDetail>{};
  // Abstract method to be defined in implementations
  Future<ArticleDetail> fetch(String id);
  Future<ArticleDetail> load(String id,
      [bool forceReload = false]) async {

    if (_cache.containsKey(id) && !forceReload) {
      return _cache[id];
    } else {
      final hnStories = await fetch(id);
      _cache[id] = hnStories;
      return hnStories;
    }
  }
}