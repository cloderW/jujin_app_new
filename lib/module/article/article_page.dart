
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:jujin_app_news/app_configuration.dart';
import 'package:jujin_app_news/module/article/article_list_view.dart';

import 'article_presenter.dart';

class ArticlePage extends StatefulWidget {

  const ArticlePage(this.configuration, this.updater);

  final AppConfiguration configuration;
  final ValueChanged<AppConfiguration> updater;

  @override
  ArticlePageState createState() => new ArticlePageState();

}

class ArticlePageState extends State<ArticlePage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();


    Widget _buildBody(BuildContext context) {
     return new DefaultTabController(
        length: choices.length,
        child: new Scaffold(
          appBar: new TabBar(
              isScrollable: true,
              tabs: choices.map((String choice) {
                return new Tab(
                  text: choice,
                );
              }).toList(),
            ),

          body: new TabBarView(
            children: choices.map((String choice) {
              return new Padding(
                padding: const EdgeInsets.all(0.0),
                child: new ArticleList(widget.configuration,widget.updater ,choice)
              );
            }).toList(),
          ),
        ),
      );
  }


  List<String> choices = const <String>[
    "原油","午读","贵金属","外汇","行情","独家","成交观察","行业要闻","经纪商动态","行业相关","交易智慧"];




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: _buildBody(context),
    );
  }


}