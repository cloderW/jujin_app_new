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
  ItemTileState(FlashItem item
      ) {
    _item=item;
  }
  @override
  void initState() {
    super.initState();

  }

  Widget _buildBadge(String count, Color backgroundColor, TextTheme textTheme,double width,double height) {
    final textStyle = textTheme.caption.copyWith(
      color: Colors.white,
      fontSize: 10.0,
    );
    return new Container(
      margin: const EdgeInsets.only(bottom: 2.0),
      width:  width,
      height: height,
      decoration: new BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(12.5)
      ),
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

  Widget _buildTop(TextTheme textTheme) {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;

    final badgeChildren = <Widget>[
      _buildBadge("", Colors.orange, textTheme,10.0,10.0),
    ];

    final itemColumn = new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildBadge(_item.publish_time.substring(10), Colors.orange, textTheme,60.0,20.0),
          _buildTop(textTheme),
          _buildText('by ${_item.source_site}', textTheme)

        ]);

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
