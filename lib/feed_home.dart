import 'feed_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class FeedHome extends StatefulWidget {
  final FeedConfiguration configuration;
  final ValueChanged<FeedConfiguration> updater;

  const FeedHome(this.configuration, this.updater);

  @override
  FeedHomeState createState() => new FeedHomeState();
}

class FeedHomeState extends State<FeedHome> {
  String _serverName;
  int _portNumber;

  void _commit() {
    //On here, update and NAVIGATE
    if (widget.updater != null) {
      widget.updater(widget.configuration
          .copyWith(serverName: _serverName, portNum: _portNumber));
      Navigator.pushNamed(context, "/feed");
    }
  }

  @override
  Widget build(BuildContext context) {
    var sName = widget.configuration.serverName;
    var pNum = widget.configuration.portNum;

    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Feed Setup"),
            elevation:
                Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0),
        floatingActionButton: new FloatingActionButton(
            tooltip: "Connect",
            child: new Icon(Icons.check),
            onPressed: _commit),
        body: new Center(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              new Text("Server Name"),
              new TextField(
                  controller: new TextEditingController(text: sName),
                  obscureText: false,
                  autofocus: true,
                  onChanged: onServerNameChanged,
                  textAlign: TextAlign.center),
              new Text("Port Number"),
              new TextField(
                  controller: new TextEditingController(text: pNum.toString()),
                  obscureText: false,
                  textAlign: TextAlign.center,
                  onChanged: _onPortNumChanged,
                  keyboardType: TextInputType.number)
            ])));
  }

  void onServerNameChanged(String value) {
    _serverName = value;
    debugPrint("Server Name: " + _serverName);
  }

  void _onPortNumChanged(String value) {
    _portNumber = int.parse(value);
    debugPrint("Port number " + _portNumber.toString());
  }
}
