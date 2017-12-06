import 'package:flutter/material.dart';
import 'package:jujin_app_news/app_configuration.dart';
import 'package:jujin_app_news/model/jujin_flash.dart';

class ItemTile extends StatefulWidget {
  final AppConfiguration configuration;
  final FlashItem item;



  ItemTile(this.item, this.configuration);

  @override
  ItemTileState createState() => new ItemTileState(item);
}

class ItemTileState extends State<ItemTile> {
  FlashItem _item;
  ItemTileState(FlashItem item) {
    _item = item;
  }
  @override
  void initState() {
    super.initState();
  }

  final _scaffoldKey = new GlobalKey<ItemTileState>();

  Widget _buildTime(String count, Color backgroundColor, TextTheme textTheme) {
    final textStyle = textTheme.caption.copyWith(
      color: Colors.white,
      fontSize: 10.0,
    );
    return new Container(
      width: 60.0,
      height: 20.0,
      decoration: new BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(10.0)),
      child: new Container(
        padding: const EdgeInsets.all(2.0),
        child: new Center(
          child: new Text(
            '$count',
            style: textStyle,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(TextTheme textTheme) {
    final children = <TextSpan>[];
    return new RichText(
      text: new TextSpan(
        text: '${_item.body}',
        style: textTheme.body2,
        children: children,
      ),
    );
  }

  Widget _buildText(String text, TextTheme textTheme) {
    return new Container(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: new Text(
          text.isNotEmpty ? text : "",
          style: textTheme.caption,
        ));
  }

  _buildBadge(Color backgroundColor, TextTheme textTheme) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              width: 10.0,
              height: 10.0,
              decoration: new BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,

              ),
            ),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              width: 20.0,
              height: 1.0,
              decoration: new BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.rectangle,
              ),
            )
          ],
        ),




      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    final badgeChildren = <Widget>[
      _buildBadge(Colors.orange, textTheme),
    ];

    final itemColumn = new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTime(
              _item.publish_time.substring(10), Colors.orange, textTheme),
          _buildContent(textTheme),
          _buildText('by ${_item.source_site}', textTheme)
        ]);

    return new InkWell(
      child: new Container(
        key: _scaffoldKey,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: new Row(
          children: <Widget>[
            new FittedBox(
                child: new Column(
                children: badgeChildren,
              ),
            ),
            new Expanded(
              flex: 1,
              child: itemColumn,
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
