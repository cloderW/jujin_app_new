import 'dart:async';


class ArticleItem {
  // API properties
  int id;
  String title;
  String created;
  String catTitle;
  String metadesc;
  String imgurl;
  String author;

  ArticleItem({
    this.id,
    this.title,
    this.catTitle,
    this.metadesc,
    this.imgurl,
    this.author,
    this.created,
  });
}

class ArticleData {
  int success;
  List<ArticleItem> value;
  ArticleData(Map<String, dynamic> map) {
    this.success = map["success"];
    List<Map<String, dynamic>> list = map["value"];
    List<ArticleItem> values = new List();
    for (int i = 0; i < list.length; i++) {
      Map<String, dynamic> value = list[i];
      ArticleItem articleItem = new ArticleItem(id: value["id"],title: value["title"],
          created: value["created"], imgurl: value["imgurl"]);
      values.add(articleItem);
    }
    this.value = values;
  }
}

class Article {

  final List<ArticleItem> articleList;

  const Article({this.articleList});

  Article.fromList(this.articleList);

}

abstract class ArticleRepository {
  static final _cache = <String,Article>{};
  // Abstract method to be defined in implementations
  Future<Article> fetch(String page,String num,String cat);
  Future<Article> load(String page,String num,String cat,
      [bool forceReload = false]) async {

    if (_cache.containsKey(page+","+num+","+cat) && !forceReload) {
      return _cache[page+","+num+","+cat];
    } else {
      final hnStories = await fetch(page,num,cat);
      _cache[page+","+num+","+cat] = hnStories;
      return hnStories;
    }
  }
}
