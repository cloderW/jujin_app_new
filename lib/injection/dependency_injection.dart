

import 'package:jujin_app_news/model/jujin_flash_live.dart';
import 'package:jujin_app_news/model/jujin_flash.dart';

import 'package:jujin_app_news/model/jujin_calender_live.dart';
import 'package:jujin_app_news/model/jujin_calender.dart';

import 'package:jujin_app_news/model/jujin_article.dart';
import 'package:jujin_app_news/model/jujin_article_live.dart';

import 'package:jujin_app_news/model/jujin_article_detail.dart';
import 'package:jujin_app_news/model/jujin_article_detail_live.dart';

enum Environment { mock, production }

class Injector {
  static final _singleton = new Injector._internal();
  static Environment _environment;

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  static void configure(Environment environment) {
    _environment = environment;
  }

  FlashRepository get flashStoriesRepository {
    switch (_environment) {
      case (Environment.mock):
        return new LiveFlashRepository();
      case (Environment.production):
      default:
        return new LiveFlashRepository();
    }
  }


  CalenderRepository get calenderRepository {
    switch (_environment) {
      case (Environment.mock):
        return new LiveCalenderRepository();
      case (Environment.production):
      default:
        return new LiveCalenderRepository();
    }
  }

  ArticleRepository get articleRepository {
    switch (_environment) {
      case (Environment.mock):
        return new LiveArticleRepository();
      case (Environment.production):
      default:
        return new LiveArticleRepository();
    }
  }

  ArticleDetailRepository get articleDetailRepository {
    switch (_environment) {
      case (Environment.mock):
        return new LiveArticleDetailRepository();
      case (Environment.production):
      default:
        return new LiveArticleDetailRepository();
    }
  }

}

