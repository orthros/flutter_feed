import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

class FeedMessage extends StatelessWidget {
  FeedMessage(
      {this.title, this.text, this.creationTime, this.animationController});

  ///The title of the Message
  final String title;

  ///The text to display in the message
  final String text;

  ///The time the message was created
  final DateTime creationTime;

  ///Animation Controller
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
        sizeFactor: new CurvedAnimation(
            parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: new Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(right: 16.0),
                child:
                    new CircleAvatar(child: new Text(title[0].toUpperCase())),
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                            margin: const EdgeInsets.only(right: 5.0),
                            child: new Text(title,
                                style: Theme.of(context).textTheme.subhead)),
                        new Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 5.0),
                            child: new Text(
                                new intl.DateFormat.yMd()
                                    .add_Hms()
                                    .format(creationTime),
                                style: Theme.of(context).textTheme.caption)),
                      ]),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: new Text(text, softWrap: true),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
