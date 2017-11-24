import 'package:flutter/material.dart';
import 'package:jujin_app_news/app_configuration.dart';
import 'package:jujin_app_news/model/jujin_calender.dart';


class ItemTile extends StatefulWidget {
  final AppConfiguration configuration;
  final CalenderItem item;

  ItemTile(this.item, this.configuration);

  @override
  ItemTileState createState() => new ItemTileState(item);
}

class ItemTileState extends State<ItemTile> {

  CalenderItem _item;
  ItemTileState(CalenderItem item
      ) {
    _item=item;
  }
  @override
  void initState() {
    super.initState();

  }

  Widget _buildTime(String time, Color backgroundColor, TextTheme textTheme) {
    final textStyle = textTheme.caption.copyWith(
      color: Colors.white,
      fontSize: 10.0,
    );
    return new Container(
      margin: const EdgeInsets.only(bottom: 2.0),
      width:  60.0,
      height: 20.0,
      decoration: new BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(12.5)
      ),
      child: new Container(
        padding: const EdgeInsets.all(2.0),
        child: new Center(
          child: new Text(
            '$time',
            style: textStyle,
          ),
        ),
      ),
    );
  }


  Widget _buildCountry(String country,String import,TextTheme textTheme) {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Image(image:new AssetImage('images/$country.png'),width: 20.0,height: 13.0,),
          new Text(
            country.isNotEmpty&&country!="null" ? '  ${country}'.padRight(7): "  --".padRight(7),
            style: textTheme.subhead,
          ),
          _buildStar(import)

        ],
      ),
    );
  }


  Widget _buildStar(String import) {
    switch(import){
      case "0":
        return new Container(
          child: new Row(
            children: <Widget>[
              new Icon(Icons.star,color: Colors.grey,size: 20.0,),
              new Icon(Icons.star,color: Colors.grey,size: 20.0),
              new Icon(Icons.star,color: Colors.grey,size: 20.0),
              new Icon(Icons.star,color: Colors.grey,size: 20.0),
              new Icon(Icons.star,color: Colors.grey,size: 20.0),
            ],
          ),
        );
      case "1":
        return new Container(
          child: new Row(
            children: <Widget>[
              new Icon(Icons.star,color: Colors.orange,size: 20.0,),
              new Icon(Icons.star,color: Colors.grey,size: 20.0),
              new Icon(Icons.star,color: Colors.grey,size: 20.0),
              new Icon(Icons.star,color: Colors.grey,size: 20.0),
              new Icon(Icons.star,color: Colors.grey,size: 20.0),
            ],
          ),
        );
      case "2":
        return new Container(
          child: new Row(
            children: <Widget>[
              new Icon(Icons.star,color: Colors.orange,size: 20.0,),
              new Icon(Icons.star,color: Colors.orange,size: 20.0),
              new Icon(Icons.star,color: Colors.grey,size: 20.0),
              new Icon(Icons.star,color: Colors.grey,size: 20.0),
              new Icon(Icons.star,color: Colors.grey,size: 20.0),
            ],
          ),
        );
      case "3":
        return new Container(
          child: new Row(
            children: <Widget>[
              new Icon(Icons.star,color: Colors.orange,size: 20.0,),
              new Icon(Icons.star,color: Colors.orange,size: 20.0),
              new Icon(Icons.star,color: Colors.orange,size: 20.0),
              new Icon(Icons.star,color: Colors.grey,size: 20.0),
              new Icon(Icons.star,color: Colors.grey,size: 20.0),
            ],
          ),
        );
      case "4":
        return new Container(
          child: new Row(
            children: <Widget>[
              new Icon(Icons.star,color: Colors.orange,size: 20.0,),
              new Icon(Icons.star,color: Colors.orange,size: 20.0),
              new Icon(Icons.star,color: Colors.orange,size: 20.0),
              new Icon(Icons.star,color: Colors.orange,size: 20.0),
              new Icon(Icons.star,color: Colors.grey,size: 20.0),
            ],
          ),
        );
      case "5":
        return new Container(
          child: new Row(
            children: <Widget>[
              new Icon(Icons.star,color: Colors.orange,size: 20.0,),
              new Icon(Icons.star,color: Colors.orange,size: 20.0),
              new Icon(Icons.star,color: Colors.orange,size: 20.0),
              new Icon(Icons.star,color: Colors.orange,size: 20.0),
              new Icon(Icons.star,color: Colors.orange,size: 20.0),
            ],
          ),
        );


    }



    return new Container(
      margin: const EdgeInsets.all(10.0),
      child: new Row(
        children: <Widget>[
          new Icon(Icons.star,color: Colors.grey,size: 20.0,),
          new Icon(Icons.star,color: Colors.grey,size: 20.0),
          new Icon(Icons.star,color: Colors.grey,size: 20.0),
          new Icon(Icons.star,color: Colors.grey,size: 20.0),
          new Icon(Icons.star,color: Colors.grey,size: 20.0),
        ],
      ),
    );
  }



  Widget _buildContent(String content,TextTheme textTheme) {
    final children = <TextSpan>[];
    return new RichText(
      text: new TextSpan(
        text: '${content}',
        style: textTheme.body2,
        children: children,
      ),
    );
  }





  Widget _buildDataValue(String previous, String surver,String actual,TextTheme textTheme) {
    return new Container(
        child: new Row(
          children: <Widget>[
            new Text(
              previous.isNotEmpty&&previous!="null" ? '前值:${previous.padRight(12)}': "前值:--".padRight(15),
              style: textTheme.caption,
            ),
            new Text(
              surver.isNotEmpty&&surver!="null" ? '预测:${surver.padRight(12)}': "预测:--".padRight(15),
              style: textTheme.caption,
            ),
            new Text(
              actual.isNotEmpty&&actual!="null" ? '公布:${actual.padRight(12)}': "公布:--".padRight(15),
              style: textTheme.caption,
            ),
          ],
        ),
    );



  }




  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    final time = _item.type==1?_item.stime:_item.event_time;

    final badgeChildren = <Widget>[
      _buildTime(time.substring(10), Colors.orange, textTheme),
    ];

    Column itemColumn;

    if(_item.type==1){
      itemColumn = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
         _buildCountry(_item.country_cn,_item.idx_relevance,textTheme),
        _buildContent(_item.title,textTheme),
        _buildDataValue(_item.previous_price,_item.surver_price,_item.actual_price, textTheme)

      ]);
    }else{
      itemColumn = new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildCountry(_item.country,_item.importance,textTheme),
            _buildContent(_item.event_desc,textTheme),
          ]);
    }




    return new InkWell(
      child: new Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: new Row(
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.only(right: 10.0,top: 5.0),
              child: new Column(
                children: badgeChildren,
              ),
            ),
            new Expanded(
              flex: 6,
              child: itemColumn,
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
