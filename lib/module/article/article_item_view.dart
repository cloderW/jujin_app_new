import 'package:flutter/material.dart';
import 'package:jujin_app_news/app_configuration.dart';
import 'package:jujin_app_news/model/jujin_article.dart';
import 'package:jujin_app_news/module/article/article_detail_view.dart';
import 'package:jujin_app_news/model/jujin_article_detail.dart';
import 'package:jujin_app_news/module/article/article_detail_presenter.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class ItemTile extends StatefulWidget {
  final AppConfiguration configuration;
  final ArticleItem item;
  final ValueChanged<AppConfiguration> updater;

  const ItemTile(this.item, this.configuration,this.updater);

  @override
  ItemTileState createState() => new ItemTileState(item);
}

class ItemTileState extends State<ItemTile> implements ArticleListViewContract {

  static const platform = const MethodChannel('com.jujin.news/article');

  ArticleItem _item;
  ItemTileState(ArticleItem item) {
    _item = item;
  }
  ArticleDetailPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = new ArticleDetailPresenter(this);
  }

  void onLoadArticleDetailComplete(ArticleDetail item){

    if (mounted) {
      _showContent(item.articleDetail.introtext,item.articleDetail.title);
    }

  }


  void onLoadArticleDetailError(){


  }


  final _scaffoldKey = new GlobalKey<ItemTileState>();


  Widget _buildContent(TextTheme textTheme) {
    final children = <TextSpan>[];
    return new RichText(
      text: new TextSpan(
        text: '${_item.title}',
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

  _buildImage(Color backgroundColor, TextTheme textTheme) {

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Image.network('http://www.9dfx.com/upload/picture/'+_item.imgurl,
               width: 120.0,
              height: 60.0,),
          ],
        ),

      ],
    );

  }


  void _onTapItem(ArticleItem item) {
//    final page = new MaterialPageRoute<Null>(
//      settings: new RouteSettings(name: '${item.id}'),
//      builder: (_) => new ArticleDetailPage(item.id.toString(),widget.configuration,widget.updater),
//    );
//    Navigator.of(context).push(page);

    _presenter.loadArticle(item.id.toString());
  }

  Future<Null> _showContent(String content,String title) async {
    try {

      final theme = (widget.configuration.themeName == ThemeName.light)
          ? "light"
          : "dark" ;

      Map<String, dynamic> params = {"content": content,"title":title,"theme":theme};
      final int result = await platform.invokeMethod('articleDetail',params);
    } on PlatformException catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textTheme = theme.textTheme;



    final imageChildren = <Widget>[
      _buildImage(Colors.orange, textTheme),
    ];

    final itemColumn = new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildContent(textTheme),
          _buildText('by ${_item.created}', textTheme)
        ]);

    return new InkWell(
      onTap: () => _onTapItem(_item),
      child: new Container(
        key: _scaffoldKey,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: new Row(
          children: <Widget>[
            new FittedBox(
              child: new Column(
                children: imageChildren,
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
