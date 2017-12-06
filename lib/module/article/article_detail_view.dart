
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:jujin_app_news/app_configuration.dart';
import 'package:jujin_app_news/module/article/article_detail_presenter.dart';
import 'package:jujin_app_news/model/jujin_article_detail.dart';

class ArticleDetailPage extends StatefulWidget {

  ArticleDetailPage(this.id,this.configuration, this.updater);

  final AppConfiguration configuration;
  final ValueChanged<AppConfiguration> updater;

   String id;

  @override
  State<StatefulWidget> createState() {
    return new _ArticleDetailPageState(id);
  }
}

class _ArticleDetailPageState extends State<ArticleDetailPage>  implements ArticleListViewContract {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();


  ArticleDetailPresenter _presenter;

  ArticleDetail _stories;

  String id;


  bool _forceReloadOnRefresh;

  _ArticleDetailPageState(String id) {
    _presenter = new ArticleDetailPresenter(this);
    _stories = new ArticleDetail();

    // If not refreshed by navChange, ignore story cache
    _forceReloadOnRefresh = true;
    this.id=id;
  }

  void onLoadArticleDetailComplete(ArticleDetail item){

    if (mounted) {
      setState(() {
        _stories.articleDetail=item.articleDetail;
      });
    }

  }

  @override
  void initState() {
    super.initState();
    final load = new Future<Null>.value(null);
    load.then((_) {
      _refreshIndicatorKey.currentState.show();
    });
  }


  void onLoadArticleDetailError(){


  }

  Future<Null> _onRefresh() async {
    _presenter.loadArticle(id,_forceReloadOnRefresh);
  }


  @override
  Widget build(BuildContext context) {

    String title=this._stories.articleDetail!=null?this._stories.articleDetail.title:" ";
    String introtext=this._stories.articleDetail!=null?this._stories.articleDetail.introtext:"加载中";
    return new Scaffold(
      appBar: new AppBar(title: new Text(title)),
      body: new RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _onRefresh,
        child: new ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return new Text(introtext);
          },

        ),
      )
    );
  }


}
