import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jujin_app_news/model/fetch_exception.dart';
import 'package:jujin_app_news/model/jujin_calender.dart';

const JsonCodec jsonCodec = const JsonCodec();

class LiveCalenderRepository extends CalenderRepository {
  @override
  Future<Calender> fetch(String date) async {
    String _fetchUrl='https://cj.jujin8.com/fedata?date=$date&country=&rele=&type=0';

    final response = await http.get(_fetchUrl);
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || response.body == null) {
      throw new FetchDataException(
          "Error while getting stories [StatusCode:$statusCode]");
    }

    final Map<String, dynamic> result=jsonCodec.decode(response.body);

    CalenderData calenderData=new CalenderData(result);

    return new Calender.fromList(calenderData.value);

  }
}