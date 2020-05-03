import 'package:flutter/material.dart';
import '../providers/requestItems.dart' as req;
import 'package:intl/intl.dart';

class RequestItemCard extends StatefulWidget {
  final req.RequestItem request;

  RequestItemCard(this.request);

  @override
  _RequestItemCardState createState() => _RequestItemCardState();
}

class _RequestItemCardState extends State<RequestItemCard> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: _expanded ? 294 : 164,
          child: Card(
            elevation: 4,
            clipBehavior: Clip.none,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          widget.request.imgURL,
                          width: 128,
                          height: 128,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(widget.request.itemName),
                                subtitle: Text(widget.request.userId),
                              ),
                              if (!_expanded)
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.bottomRight,
                                    child: FlatButton(
                                      textColor: Theme.of(context).accentColor,
                                      onPressed: () {
                                        setState(
                                          () {
                                            _expanded = !_expanded;
                                          },
                                        );
                                      },
                                      child: Text('View'),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  padding: EdgeInsets.only(top: 15, left: 15, right: 10),
                  duration: Duration(milliseconds: 300),
                  height: _expanded ? 130 : 0,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          widget.request.itemDescription,
                        ),
                        if (widget.request.date != null)
                          Text(
                            'Need by: ' +
                                DateFormat.yMMMMEEEEd()
                                    .format(widget.request.date)
                                    .toString(),
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FlatButton(
                                textColor: Theme.of(context).accentColor,
                                onPressed: () {},
                                child: Text('Chat'),
                              ),
                              FlatButton(
                                textColor: Theme.of(context).accentColor,
                                onPressed: () {
                                  setState(
                                    () {
                                      _expanded = !_expanded;
                                    },
                                  );
                                },
                                child: Text('Shrink'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
