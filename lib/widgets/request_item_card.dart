import 'package:flutter/material.dart';
import '../providers/requestItems.dart' as req;

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
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded ? 300 : 150,
    );
  }
}
