
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:jujin_app_news/app_configuration.dart';
import 'package:jujin_app_news/model/jujin_flash.dart';

import 'package:jujin_app_news/module/flash/flash_item_view.dart';
import 'flash_presenter.dart';

class FlashPage extends StatefulWidget {

  const FlashPage(this.configuration, this.updater);

  final AppConfiguration configuration;
  final ValueChanged<AppConfiguration> updater;

  @override
  FlashPageState createState() => new FlashPageState();

}

class FlashPageState extends State<FlashPage>
    implements FlashListViewContract {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  int currentPage=1;
  int pageSize=20;
  FlashListPresenter _presenter;

  Flash _stories;
  int _storyCount;
  bool _forceReloadOnRefresh;

  FlashPageState() {
    _presenter = new FlashListPresenter(this);
    _stories = new Flash(flashList: <FlashItem>[]);
    _storyCount = 0;
    // If not refreshed by navChange, ignore story cache
    _forceReloadOnRefresh = true;
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
  void onLoadFlashComplete(Flash flash) {
    if (mounted) {
      setState(() {
        _stories.flashList.addAll(flash.flashList);
        _storyCount = _stories.flashList.length;
      });
    }
  }

  @override
  void onLoadFlashError() {
    // TODO: implement onLoadStoriesError
  }

  Widget _buildBody(BuildContext context) {
    final padding = const EdgeInsets.all(8.0);
    RefreshIndicator refreshIndicator= new RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
      child: new ListView.builder(
        padding: padding,
        itemCount: _storyCount,
        itemBuilder: (BuildContext context, int index) {
          if(index+1==_stories.flashList.length){
             currentPage=(_stories.flashList.length/pageSize).floor()+1;
             _presenter.loadFlash(currentPage.toString(),pageSize.toString(), _forceReloadOnRefresh);
          }
          FlashItem flash = _stories.flashList[index];
          return new ItemTile(flash, widget.configuration);
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

    _stories.flashList.clear();

    _storyCount=0;

    currentPage=1;

    _presenter.loadFlash(currentPage.toString(),pageSize.toString(), _forceReloadOnRefresh);

  }

}