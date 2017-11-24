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

  FlashListPresenter _presenter;

  Flash _stories;
  int _storyCount;
  int _selectedNavIndex;
  bool _forceReloadOnRefresh;

  FlashPageState() {
    _presenter = new FlashListPresenter(this);

    _stories = new Flash(flashList: <FlashItem>[]);
    _storyCount = 0;
    _selectedNavIndex = 0;

    // If not refreshed by navChange, ignore story cache
    _forceReloadOnRefresh = true;
  }

  @override
  void initState() {
    super.initState();

    // Show RefreshIndicator
    // This will call onRefresh() method and load stories
    final load = new Future<Null>.value(null);
    load.then((_) {
      _refreshIndicatorKey.currentState.show();
    });
  }

  @override
  void onLoadFlashComplete(Flash flash) {
    if (mounted) {
      setState(() {
        _stories = flash;
        _storyCount = flash.flashList.length;
      });
    }
  }

  @override
  void onLoadFlashError() {
    // TODO: implement onLoadStoriesError
  }

  void _handleThemeChange(bool darkTheme) {
    final theme = darkTheme ? ThemeName.dark : ThemeName.light;
    storeThemeToPrefs(theme);

    if (widget.updater != null)
      widget.updater(widget.configuration.copyWith(themeName: theme));
  }


  BottomNavigationBarItem _buildNavItem(IconData icon, String title) {
    final titleColor = (widget.configuration.themeName == ThemeName.light)
        ? Colors.black
        : Colors.white;


    return new BottomNavigationBarItem(
      icon: new Icon(icon,color: Colors.orange),
      title: new Text(title,style: new TextStyle(color: titleColor))
    );
  }

  Widget _buildAppTitle(BuildContext context) {
    final titleColor = (widget.configuration.themeName == ThemeName.light)
        ? Colors.white
        : Colors.orange;

    return new Row(children: <Widget>[

      new Text("聚金数据",
          style: new TextStyle(color: titleColor))
    ]);
  }

  Widget _buildDrawer(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          new DrawerHeader(
              child: new Center(
                  child: new Text("设置"))),
          new ListTile(
            title: const Text('Night mode'),
            trailing: new Switch(
              value: widget.configuration.themeName == ThemeName.dark,
              onChanged: _handleThemeChange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final padding = const EdgeInsets.all(8.0);
    return new RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
      child: new ListView.builder(
        padding: padding,
        itemCount: _storyCount,
        itemBuilder: (BuildContext context, int index) {
          FlashItem flash = _stories.flashList[index];
          return new ItemTile(flash, widget.configuration);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: _buildAppTitle(context),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      drawer: _buildDrawer(context),
      bottomNavigationBar: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          _buildNavItem(Icons.whatshot, '快讯'),
          _buildNavItem(Icons.new_releases, '行情'),
          _buildNavItem(Icons.view_compact, '资讯'),
          _buildNavItem(Icons.question_answer, '日历'),
          _buildNavItem(Icons.work, '关于'),
        ],
        currentIndex: _selectedNavIndex,
        onTap: _handleNavChange,
      ),
      body: _buildBody(context),
    );
  }

  Future<Null> _onRefresh() async {

//    setState(() {
//      _stories = new Flash(flashList: <FlashItem>[]);
//      _storyCount = 0;
//    });


    _presenter.loadFlash("1","20", _forceReloadOnRefresh);

    // Unless refreshed by navChange, always ignore story cache
    _forceReloadOnRefresh = true;

    // onLoadStoriesComplete calls setState afterwards
  }


  void _handleNavChange(int value) {
    if (value == _selectedNavIndex) {
      return;
    }

    _selectedNavIndex = value;
    _forceReloadOnRefresh = false;

    // This will show refresh indicator and call onRefresh()
    _refreshIndicatorKey.currentState.show();
  }
}