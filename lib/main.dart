library feed;

import 'dart:async';

import 'feed_home.dart';
import 'feed_screen.dart';
import 'feed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'
    show
        debugPaintSizeEnabled,
        debugPaintBaselinesEnabled,
        debugPaintLayerBordersEnabled,
        debugPaintPointersEnabled,
        debugRepaintRainbowEnabled;
import 'package:intl/intl.dart';

class FeedApp extends StatefulWidget {
  @override
  FeedAppState createState() => new FeedAppState();
}

class FeedAppState extends State<FeedApp> {
  FeedConfiguration _configuration = new FeedConfiguration(
      serverName: "10.0.2.2",
      portNum: 6379,
      debugShowGrid: false,
      debugShowSizes: false,
      debugShowBaselines: false,
      debugShowLayers: false,
      debugShowPointers: false,
      debugShowRainbow: false,
      showPerformanceOverlay: false,
      showSemanticsDebugger: false);

  void configurationUpdater(FeedConfiguration value) {
    setState(() {
      _configuration = value;
    });
  }

  ThemeData get theme {
    //TODO: Put in an much better looking theme
    return new ThemeData(
        brightness: Brightness.light, primarySwatch: Colors.purple);
  }

  @override
  Widget build(BuildContext context) {
    assert(() {
      debugPaintSizeEnabled = _configuration.debugShowSizes;
      debugPaintBaselinesEnabled = _configuration.debugShowBaselines;
      debugPaintLayerBordersEnabled = _configuration.debugShowLayers;
      debugPaintPointersEnabled = _configuration.debugShowPointers;
      debugRepaintRainbowEnabled = _configuration.debugShowRainbow;
      return true;
    });

    return new MaterialApp(
      title: 'Feed',
      theme: theme,
      debugShowMaterialGrid: _configuration.debugShowGrid,
      showPerformanceOverlay: _configuration.showPerformanceOverlay,
      showSemanticsDebugger: _configuration.showSemanticsDebugger,
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) =>
            new FeedHome(_configuration, configurationUpdater),
        '/feed': (BuildContext context) =>
            new FeedScreen(_configuration, configurationUpdater)
      },
    );
  }
}

void main() {
  runApp(new FeedApp());
}
