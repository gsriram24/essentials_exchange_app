import 'package:essentials_exchange/providers/user.dart';
import 'package:essentials_exchange/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import '../providers/requestItems.dart' as req;
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RequestItemCard extends StatefulWidget {
  final req.RequestItem request;

  RequestItemCard(this.request);

  @override
  _RequestItemCardState createState() => _RequestItemCardState();
}

class _RequestItemCardState extends State<RequestItemCard> {
  var fullName = '';
  var _expanded = false;
  var userData;
  var uid;
  @override
  void didChangeDependencies() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    setState(() {
      uid = user.uid;
    });
    UserData.fetchUserData(uid).then((value) {
      setState(() {
        userData = value;
      });
    });
    super.didChangeDependencies();
  }

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
                                subtitle: Text(widget.request.fullName),
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
                              if (uid != widget.request.userId)
                                FlatButton(
                                  textColor: Theme.of(context).accentColor,
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      ChatScreen.routeName,
                                      arguments: userData.name,
                                    );
                                  },
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
