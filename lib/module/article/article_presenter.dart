import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:jujin_app_news/injection/dependency_injection.dart';
import 'package:jujin_app_news/model/jujin_article.dart';

abstract class ArticleListViewContract {
  void onLoadArticleComplete(Article items);
  void onLoadArticleError();
}

class ArticleListPresenter {
  ArticleListViewContract _view;
  ArticleRepository _repository;

  ArticleListPresenter(this._view) {
    _repository = new Injector().articleRepository;
  }

  Future<Null> loadArticle(String page,String num,String cat,
      [bool forceReload = false]) async {
    assert(_view != null);
    try {
      final calender = await _repository.load(page,num,cat);
      _view.onLoadArticleComplete(calender);
    } catch (e) {
      debugPrint('Exception while loading stories:\n  $e');
      _view.onLoadArticleError();
    }
  }
}