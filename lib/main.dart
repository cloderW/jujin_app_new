import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jujin_app_news/app_configuration.dart';
import 'package:jujin_app_news/injection/dependency_injection.dart';
import 'package:jujin_app_news/main_page.dart';

void main() {
  // Injector for selecting data source: Environment.production or Environment.mock
  Injector.configure(Environment.production);
  runApp(new JujinNewsApp());
}

class JujinNewsApp extends StatefulWidget {
  @override
  JujinNewsAppState createState() => new JujinNewsAppState();
}


class JujinNewsAppState extends State<JujinNewsApp> {
  // Default configuration
  var _configuration = new AppConfiguration(
    themeName: ThemeName.light,
    showFullComment: false,
    expandCommentTree: false,
  );

  @override
  void initState() {
    super.initState();

    // Load configuration from shared preferences
    AppConfiguration
        .loadFromPrefs()
        .then((AppConfiguration config) {
      if (mounted) {
        configurationUpdater(config);
      }
    });
  }

  // App theme settings
  ThemeData get theme {
    assert(_configuration.themeName != null);
    switch (_configuration.themeName) {
      case ThemeName.light:
        return new ThemeData(
            brightness: Brightness.light, primarySwatch: Colors.orange);
      case ThemeName.dark:
        return new ThemeData(
            brightness: Brightness.dark, accentColor: Colors.orangeAccent);
    }
    return null;
  }

  void configurationUpdater(AppConfiguration value) {
    setState(() {
      _configuration = value;
    });
  }



  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: theme,
      home: new MainPage(_configuration, configurationUpdater),
    );
  }
}
