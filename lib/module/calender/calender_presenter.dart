import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:jujin_app_news/injection/dependency_injection.dart';
import 'package:jujin_app_news/model/jujin_calender.dart';

abstract class CalenderListViewContract {
  void onLoadCalenderComplete(Calender items);
  void onLoadCalenderError();
}

class CalenderListPresenter {
  CalenderListViewContract _view;
  CalenderRepository _repository;

  CalenderListPresenter(this._view) {
    _repository = new Injector().calenderRepository;
  }

  Future<Null> loadCalender(String date,
      [bool forceReload = false]) async {
    assert(_view != null);
    try {
      final calender = await _repository.load(date);
      _view.onLoadCalenderComplete(calender);
    } catch (e) {
      debugPrint('Exception while loading stories:\n  $e');
      _view.onLoadCalenderError();
    }
  }
}