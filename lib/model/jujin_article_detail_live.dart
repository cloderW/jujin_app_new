import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jujin_app_news/model/fetch_exception.dart';
import 'package:jujin_app_news/model/jujin_article_detail.dart';

const JsonCodec jsonCodec = const JsonCodec();

class LiveArticleDetailRepository extends ArticleDetailRepository {
  @override
  Future<ArticleDetail> fetch(String id) async {
    String _fetchUrl='https://cj.jujin8.com/articledetail?id=$id';

    final response = await http.get(_fetchUrl);
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || response.body == null) {
      throw new FetchDataException(
          "Error while getting stories [StatusCode:$statusCode]");
    }

    final Map<String, dynamic> result=jsonCodec.decode(response.body);

    ArticleDetailData articleData=new ArticleDetailData(result);

    return new ArticleDetail.fromMap(articleData.value);

  }
}