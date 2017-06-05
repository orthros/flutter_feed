import 'dart:async';
import 'feed_message.dart';
import 'feed_types.dart';
import 'package:flutter/material.dart';
import 'src/message.dart';
import 'src/redisTopics.dart';

class FeedScreen extends StatefulWidget {
  final FeedConfiguration configuration;
  final ValueChanged<FeedConfiguration> updater;

  const FeedScreen(this.configuration, this.updater);

  @override
  FeedScreenState createState() => new FeedScreenState();
}

class FeedScreenState extends State<FeedScreen> with TickerProviderStateMixin {
  final List<FeedMessage> _messages = <FeedMessage>[];

  RedisTopics _topics;

  void _handleSubmitted(String title, String text, DateTime time) {
    FeedMessage message = new FeedMessage(
      title: title,
      text: text,
      creationTime: time,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      if (_messages.length == 100) {
        _messages.removeLast();
      }
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  void dispose() {
    for (FeedMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    Function onMessage =
        (Message m) => _handleSubmitted(m.topic, m.body, m.timeStamp);

    _topics = new RedisTopics(widget.configuration.serverName,
        widget.configuration.portNum, onMessage);
  }

  Widget _buildTextComposer() {
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
    );
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Feed"),
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0),
      body: new Container(
          child: new Column(children: <Widget>[
            new Flexible(
                child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            )),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ]),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border:
                      new Border(top: new BorderSide(color: Colors.grey[200])))
              : null),
    );
  }
}
