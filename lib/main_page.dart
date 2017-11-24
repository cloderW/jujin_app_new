
import 'package:flutter/material.dart';
import 'package:jujin_app_news/module/flash/flash_page.dart';
import 'package:jujin_app_news/module/calender/calender_page.dart';
import 'package:jujin_app_news/app_configuration.dart';

class MainPage extends StatefulWidget {

  const MainPage(this.configuration, this.updater);

  final AppConfiguration configuration;
  final ValueChanged<AppConfiguration> updater;

  @override
  State<StatefulWidget> createState() {
    return new _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {

  PageController pageController;
  int page = 0;

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        backgroundColor: Colors.white,
        drawer: _buildDrawer(context),
        appBar: new AppBar(
          title: _buildAppTitle(context),
          elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
        ),
        body: new PageView(
            children: [
              new FlashPage(widget.configuration,widget.updater),
              new FlashPage(widget.configuration,widget.updater),
              new CalendarPage(widget.configuration,widget.updater),
            ],
            controller: pageController,
            onPageChanged: onPageChanged
        ),
        bottomNavigationBar: new BottomNavigationBar(
            items: [
              new BottomNavigationBarItem(
                icon: new Icon(Icons.stars),
                title: new Text("快讯"),
              ),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.fiber_new), title: new Text("资讯")),
              new BottomNavigationBarItem(
                  icon: new Icon(Icons.calendar_today), title: new Text("日历"))
            ],
            onTap: onTap,
            currentIndex: page
        )
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


  @override
  void initState() {
    super.initState();
    pageController = new PageController(initialPage: this.page);
  }


  void onTap(int index) {
    pageController.animateToPage(
        index, duration: const Duration(milliseconds: 300),
        curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }



  void _handleThemeChange(bool darkTheme) {
    final theme = darkTheme ? ThemeName.dark : ThemeName.light;
    storeThemeToPrefs(theme);

    if (widget.updater != null)
      widget.updater(widget.configuration.copyWith(themeName: theme));
  }



  void _handleCalanderChange(bool data) {
    final theme = data ? ThemeName.dark : ThemeName.light;
    storeThemeToPrefs(theme);

    if (widget.updater != null)
      widget.updater(widget.configuration.copyWith(themeName: theme));
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


}
