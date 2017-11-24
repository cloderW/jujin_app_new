import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:jujin_app_news/injection/dependency_injection.dart';
import 'package:jujin_app_news/model/jujin_flash.dart';

abstract class FlashListViewContract {
  void onLoadFlashComplete(Flash items);
  void onLoadFlashError();
}

class FlashListPresenter {
  FlashListViewContract _view;
  FlashRepository _repository;

  FlashListPresenter(this._view) {
    _repository = new Injector().flashStoriesRepository;
  }

  Future<Null> loadFlash(String page,String number,
      [bool forceReload = false]) async {
    assert(_view != null);
    try {
      final stories = await _repository.load(page,number,forceReload);
      _view.onLoadFlashComplete(stories);
    } catch (e) {
      debugPrint('Exception while loading stories:\n  $e');
      _view.onLoadFlashError();
    }
  }
}
