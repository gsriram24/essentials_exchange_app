import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RequestItem {
  final String itemName;
  final String itemDescription;
  final String userId;
  final String imgURL;
  final DateTime date;

  RequestItem(
    @required this.itemName,
    this.itemDescription,
    this.userId,
    @required this.imgURL,
    this.date,
  );
}

// THis line was added

class Requests with ChangeNotifier {
  static var requests = [
    RequestItem(
      'Milk',
      'I have changed this text. Add any item description or specifics here.',
      'sgcuber24++',
      'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      DateTime.now(),
    ),
    RequestItem(
      'Rubik\'s Cube',
      'Lorem Ipsum this is description. Add any item description or specifics here. Pls gimme cube my life is bad.',
      'ashwin2607',
      'https://images.pexels.com/photos/19677/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      DateTime.now(),
    ),
    RequestItem(
      'Phone Charger',
      'Lorem Ipsum this is description. Add any item description or specifics here. My phone battery is low I need to charge pls',
      'dollarakshay',
      'https://images.pexels.com/photos/1028674/pexels-photo-1028674.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      DateTime.now(),
    ),
    RequestItem(
      'Soap and Shampoo',
      'Lorem Ipsum this is description. Add any item description or specifics here. I need to take bath pls give me.',
      'yaegerknight',
      'https://images.pexels.com/photos/545014/pexels-photo-545014.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      DateTime.now(),
    ),
  ];

  List<RequestItem> _filteredRequests = requests;
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

  Future<void> addItemToDatabase(RequestItem item) async {
    var imageURL = null;

    final response = await http.post(
      'https://essentials-exchange.firebaseio.com/items.json',
      body: json.encode({
        'title': item.itemName,
        'added_timestamp': DateTime.now().toIso8601String(),
        'duedate': item.date.toIso8601String(),
        'description': item.itemDescription,
        'imageURL': item.imgURL
      }),
    );

    requests.insert(0, item);
    notifyListeners();
  }
}
