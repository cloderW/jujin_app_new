import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:jujin_app_news/injection/dependency_injection.dart';
import 'package:jujin_app_news/model/jujin_article_detail.dart';

abstract class ArticleListViewContract {
  void onLoadArticleDetailComplete(ArticleDetail item);
  void onLoadArticleDetailError();
}

class ArticleDetailPresenter {
  ArticleListViewContract _view;
  ArticleDetailRepository _repository;

  ArticleDetailPresenter(this._view) {
    _repository = new Injector().articleDetailRepository;
  }

  Future<Null> loadArticle(String id,
      [bool forceReload = false]) async {
    assert(_view != null);
    try {
      final articleDetail = await _repository.load(id);
      _view.onLoadArticleDetailComplete(articleDetail);
    } catch (e) {
      debugPrint('Exception while loading stories:\n  $e');
      _view.onLoadArticleDetailError();
    }
  }
}