import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String name;
// constructor to get text from textfield
  ChatMessage({this.text, this.name});

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: new CircleAvatar(
                child: new Image.network(
                    "http://res.cloudinary.com/kennyy/image/upload/v1531317427/avatar_z1rc6f.png"),
              ),
            ),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(name, style: Theme.of(context).textTheme.subhead),
                new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: new Text(text),
                )
              ],
            )
          ],
        ));
  }
}
