import 'package:essentials_exchange/providers/requestItems.dart';
import 'package:essentials_exchange/widgets/request_item_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewRequestsScreen extends StatelessWidget {
  static const routeName = '/view-requests';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Requests',
        ),
      ),
      body: Consumer<Requests>(
        builder: (ctx, requestData, child) => ListView.builder(
          itemBuilder: (ctx, i) => RequestItemCard(requestData.requests[i]),
        ),
      ),
    );
  }
}
