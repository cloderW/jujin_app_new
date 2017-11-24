

import 'package:jujin_app_news/model/jujin_flash_live.dart';
import 'package:jujin_app_news/model/jujin_flash.dart';

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



}

