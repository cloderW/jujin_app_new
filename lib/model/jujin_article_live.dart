import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jujin_app_news/model/fetch_exception.dart';
import 'package:jujin_app_news/model/jujin_article.dart';

const JsonCodec jsonCodec = const JsonCodec();

class LiveArticleRepository extends ArticleRepository {
  @override
  Future<Article> fetch(String page,String num,String cat) async {
    String _fetchUrl='https://cj.jujin8.com/articlelist?page=$page&number=$num&cat=$cat';

    final response = await http.get(_fetchUrl);
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || response.body == null) {
      throw new FetchDataException(
          "Error while getting stories [StatusCode:$statusCode]");
    }

    final Map<String, dynamic> result=jsonCodec.decode(response.body);

    ArticleData articleData=new ArticleData(result);

    return new Article.fromList(articleData.value);

  }
}