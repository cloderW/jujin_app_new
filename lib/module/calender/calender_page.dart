import 'dart:async';
import 'package:flutter/material.dart';

import 'package:jujin_app_news/app_configuration.dart';
import 'package:jujin_app_news/model/jujin_calender.dart';

import 'package:jujin_app_news/module/calender/calender_item_view.dart';

import 'calender_presenter.dart';

class CalendarPage extends StatefulWidget {

  const CalendarPage(this.configuration, this.updater);

  final AppConfiguration configuration;
  final ValueChanged<AppConfiguration> updater;

  @override
  CalendarPageState createState() => new CalendarPageState();

}


class CalendarPageState extends State<CalendarPage>
    implements  CalenderListViewContract{
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  CalenderListPresenter _presenter;

  Calender _calender;
  int _calenderCount;
  bool _forceReloadOnRefresh;

  String _date;

  CalendarPageState() {
    _presenter = new CalenderListPresenter(this);
    _calender = new Calender(calenderList: <CalenderItem>[]);
    _calenderCount = 0;
    // If not refreshed by navChange, ignore story cache
    _forceReloadOnRefresh = true;

    _date=new DateTime.now().toString().substring(0,10);
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
  void onLoadCalenderComplete(Calender calender) {
    if (mounted) {
      setState(() {
        _calender=calender;
        _calenderCount = _calender.calenderList.length;
      });
    }
  }

  @override
  void onLoadCalenderError() {
    // TODO: implement onLoadStoriesError
  }

  Widget _buildBody(BuildContext context) {
    final padding = const EdgeInsets.all(8.0);
    RefreshIndicator refreshIndicator= new RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
      child: new ListView.builder(
        padding: padding,
        itemCount: _calenderCount,
        itemBuilder: (BuildContext context, int index) {
          CalenderItem calenderItem = _calender.calenderList[index];
          return new ItemTile(calenderItem, widget.configuration);
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

      floatingActionButton: new FloatingActionButton(

          tooltip: _date,

          child: new Icon(Icons.calendar_view_day),

          backgroundColor: Colors.orange,

          onPressed: (){
           showDatePicker(
                initialDate: new DateTime.now(),
                firstDate: new DateTime(1970),
                lastDate: new DateTime(2050),
                context: context,
            ).then(_onValue);

          }

      ),

    );
  }


  _onValue(DateTime day){

    if(day==null){
      return;
    }

    setState(() {
      _calender=new Calender();
      _calenderCount =0;
    });
    _date=day.toString().substring(0,10);
    _presenter.loadCalender(_date, _forceReloadOnRefresh);

  }


  Future<Null> _onRefresh() async {

    _forceReloadOnRefresh=true;
    _presenter.loadCalender(_date, _forceReloadOnRefresh);

  }


}