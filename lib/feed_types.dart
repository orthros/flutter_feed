import 'package:meta/meta.dart';

class FeedConfiguration {
  FeedConfiguration(
      {@required this.serverName,
      @required this.portNum,
      @required this.debugShowGrid,
      @required this.debugShowSizes,
      @required this.debugShowBaselines,
      @required this.debugShowLayers,
      @required this.debugShowPointers,
      @required this.debugShowRainbow,
      @required this.showPerformanceOverlay,
      @required this.showSemanticsDebugger}) {
    assert(serverName != null && serverName.isNotEmpty);
    assert(portNum != null && portNum > 0);
    assert(debugShowGrid != null);
    assert(debugShowSizes != null);
    assert(debugShowBaselines != null);
    assert(debugShowLayers != null);
    assert(debugShowPointers != null);
    assert(debugShowRainbow != null);
    assert(showPerformanceOverlay != null);
    assert(showSemanticsDebugger != null);
  }
  final String serverName;
  final int portNum;
  final bool debugShowGrid;
  final bool debugShowSizes;
  final bool debugShowBaselines;
  final bool debugShowLayers;
  final bool debugShowPointers;
  final bool debugShowRainbow;
  final bool showPerformanceOverlay;
  final bool showSemanticsDebugger;

  FeedConfiguration copyWith(
      {String serverName,
      int portNum,
      bool debugShowGrid,
      bool debugShowSizes,
      bool debugShowBaselines,
      bool debugShowLayers,
      bool debugShowPointers,
      bool debugShowRainbow,
      bool showPerformanceOverlay,
      bool showSemanticsDebugger}) {
    return new FeedConfiguration(
        serverName: serverName ?? this.serverName,
        portNum: portNum ?? this.portNum,
        debugShowGrid: debugShowGrid ?? this.debugShowGrid,
        debugShowSizes: debugShowSizes ?? this.debugShowSizes,
        debugShowBaselines: debugShowBaselines ?? this.debugShowBaselines,
        debugShowLayers: debugShowLayers ?? this.debugShowLayers,
        debugShowPointers: debugShowPointers ?? this.debugShowPointers,
        debugShowRainbow: debugShowRainbow ?? this.debugShowRainbow,
        showPerformanceOverlay:
            showPerformanceOverlay ?? this.showPerformanceOverlay,
        showSemanticsDebugger:
            showSemanticsDebugger ?? this.showSemanticsDebugger);
  }
}
