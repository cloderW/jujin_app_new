
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:jujin_app_news/app_configuration.dart';
import 'package:jujin_app_news/model/jujin_article.dart';
import 'package:jujin_app_news/module/article/article_item_view.dart';

import 'article_presenter.dart';

class ArticleList extends StatefulWidget {

  const ArticleList(this.configuration, this.updater,this.cat);

  final AppConfiguration configuration;
  final ValueChanged<AppConfiguration> updater;

  final String cat;

  @override
  ArticleListState createState() => new ArticleListState(cat);

}

class ArticleListState extends State<ArticleList>
    implements ArticleListViewContract {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();


  final _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  int currentPage=1;
  int pageSize=20;
  ArticleListPresenter _presenter;

  Article _stories;
  int _storyCount;
  bool _forceReloadOnRefresh;
  String _cat;

  ArticleListState(String cat) {
    _presenter = new ArticleListPresenter(this);
    _stories = new Article(articleList: <ArticleItem>[]);
    _storyCount = 0;

    // If not refreshed by navChange, ignore story cache
    _forceReloadOnRefresh = true;
    _cat=cat;
  }

  @override
  void initState() {
    super.initState();
    final load = new Future<Null>.value(null);
    load.then((_) {
      _refreshIndicatorKey.currentState.show();
    });
  }

  @override
  void onLoadArticleComplete(Article article) {
    if (mounted) {
      setState(() {
        _stories.articleList.addAll(article.articleList);
        _storyCount = _stories.articleList.length;
      });
    }
  }

  @override
  void onLoadArticleError() {
    // TODO: implement onLoadStoriesError
  }

  Widget _buildBody(BuildContext context) {
    RefreshIndicator refreshIndicator= new RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
      child: new ListView.builder(
        itemCount: _storyCount,
        itemBuilder: (BuildContext context, int index) {
          if(index+1==_stories.articleList.length){
            currentPage=(_stories.articleList.length/pageSize).floor()+1;
            _presenter.loadArticle(currentPage.toString(),pageSize.toString(), _cat,_forceReloadOnRefresh);
          }
          ArticleItem article = _stories.articleList[index];
          return new ItemTile(article, widget.configuration,widget.updater);
        },
      ),
    );
    return refreshIndicator;
  }








  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: _buildBody(context),
    );
  }

  Future<Null> _onRefresh() async {

    _stories.articleList.clear();

    _storyCount=0;

    currentPage=1;

    _presenter.loadArticle(currentPage.toString(),pageSize.toString(), _cat,_forceReloadOnRefresh);

  }

}