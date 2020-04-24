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
          height: _expanded ? 300 : 153,
          child: Card(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Image.network(
                        widget.request.imgUrl,
                        width: 150,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                widget.request.itemName,
                                style: Theme.of(context).textTheme.title,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'By: ' + widget.request.userId,
                                style: Theme.of(context).textTheme.button,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7.4),
                                child: Container(
                                  height: 1,
                                  color: Colors.white,
                                ),
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
                          style: Theme.of(context).textTheme.subtitle,
                        ),
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
