import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:essentials_exchange/providers/requestItems.dart';
import 'package:essentials_exchange/screens/add_request_screen.dart';

import 'package:essentials_exchange/widgets/app_drawer.dart';
import 'package:essentials_exchange/widgets/request_item_card.dart';

class ViewRequestsScreen extends StatefulWidget {
  static const routeName = '/view-requests';

  @override
  _ViewRequestsScreenState createState() => _ViewRequestsScreenState();
}

class _ViewRequestsScreenState extends State<ViewRequestsScreen> {
  TextEditingController editingController = TextEditingController();
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Requests>(context).fetchAndSetRequests().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var requestData = Provider.of<Requests>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Requests',
        ),
      ),
      drawer: AppDrawer(),
      body: _isLoading || requestData.requests == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: editingController,
                    decoration: InputDecoration(
                      labelText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      requestData.filterRequests(value);
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (ctx, i) =>
                        RequestItemCard(requestData.requestGetter[i]),
                    itemCount: requestData.requestGetter.length,
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          Navigator.pushNamed(context, AddRequestScreen.routeName);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
