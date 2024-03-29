import 'dart:convert';

import 'package:essentials_exchange/providers/user.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class RequestItem {
  final String id;
  final String itemName;
  final String itemDescription;
  final String userId;
  final String imgURL;
  final DateTime date;
  final String fullName;

  RequestItem(
    @required this.itemName,
    this.itemDescription,
    this.userId,
    this.imgURL,
    this.date, [
    this.fullName,
    this.id,
  ]);
}

class Requests with ChangeNotifier {
  var requests;

  List<RequestItem> _filteredRequests;
  List<RequestItem> get requestGetter {
    return [..._filteredRequests];
  }

  void filterRequests(String query) {
    print('Filtering');
    List<RequestItem> dummyList = [];
    requests.forEach(
      (item) {
        if (item.itemName.contains(query) ||
            item.itemDescription.contains(query)) {
          dummyList.add(item);
        }
      },
    );
    print(dummyList);
    _filteredRequests = dummyList;
    notifyListeners();
  }

  Future<void> fetchAndSetRequests() async {
    final url = 'https://essentials-exchange.firebaseio.com/items.json';
    final response = await http.get(url);
    final List<RequestItem> loadedRequests = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((requestId, item) {
      loadedRequests.add(
        RequestItem(
          item['title'],
          item['description'],
          item['user_id'],
          item['imageURL'],
          DateTime.parse(item['duedate']),
          item['fullName'],
          requestId,
        ),
      );
    });
    requests = loadedRequests.reversed.toList();
    _filteredRequests = loadedRequests.reversed.toList();
    notifyListeners();
  }

  Future<void> addItemToDatabase(RequestItem item) async {
    final userData = await UserData.fetchUserData(item.userId);

    var imageURL = null;

    final response = await http.post(
      'https://essentials-exchange.firebaseio.com/items.json',
      body: json.encode({
        'title': item.itemName,
        'added_timestamp': DateTime.now().toIso8601String(),
        'duedate': item.date.toIso8601String(),
        'description': item.itemDescription,
        'imageURL': item.imgURL,
        'fullName': userData.name,
        'user_id': item.userId,
      }),
    );

    requests.insert(
      0,
      RequestItem(
        item.itemName,
        item.itemDescription,
        item.userId,
        item.imgURL,
        item.date,
        userData.name,
        json.decode(response.body)['name'],
      ),
    );
    _filteredRequests = requests;
    notifyListeners();
  }
}
