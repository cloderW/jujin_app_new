import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:jujin_app_news/model/fetch_exception.dart';
import 'package:jujin_app_news/model/jujin_flash.dart';

const JsonCodec jsonCodec = const JsonCodec();

class LiveFlashRepository extends FlashRepository {
  static const _baseUrl = 'https://hacker-news.firebaseio.com/v0';
  static const _topStoriesUrl = '$_baseUrl/topstories.json';

  @override
  Future<Flash> fetch(String page,String num) async {
    String _fetchUrl='https://cj.jujin8.com/kx?page=$page&num=$num';

    final response = await http.get(_fetchUrl);
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || response.body == null) {
      throw new FetchDataException(
          "Error while getting stories [StatusCode:$statusCode]");
    }
    final Map<String, dynamic> result=jsonCodec.decode(response.body);

    FlashData flashData=new FlashData(result);

    return new Flash.fromList(flashData.value);

  }
}
