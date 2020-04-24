import 'package:flutter/foundation.dart';

class RequestItem {
  final String id;
  final String itemName;
  final String itemDescription;
  final String userId;
  final String imgUrl;
  final DateTime date;

  RequestItem({
    @required this.id,
    @required this.itemName,
    @required this.itemDescription,
    @required this.userId,
    @required this.imgUrl,
    @required this.date,
  });
}

class Requests with ChangeNotifier {
  static var requests = [
    RequestItem(
      id: '1',
      itemName: 'Milk',
      itemDescription:
          'Lorem Ipsum this is description. Add any item description or specifics here.',
      userId: 'sgcuber24',
      imgUrl:
          'https://images.pexels.com/photos/236010/pexels-photo-236010.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      date: DateTime.now(),
    ),
    RequestItem(
      id: '2',
      itemName: 'Rubik\'s Cube',
      itemDescription:
          'Lorem Ipsum this is description. Add any item description or specifics here. Pls gimme cube my life is bad.',
      userId: 'ashwin2607',
      imgUrl:
          'https://images.pexels.com/photos/19677/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      date: DateTime.now(),
    ),
    RequestItem(
      id: '3',
      itemName: 'Phone Charger',
      itemDescription:
          'Lorem Ipsum this is description. Add any item description or specifics here. My phone battery is low I need to charge pls',
      userId: 'dollarakshay',
      imgUrl:
          'https://images.pexels.com/photos/1028674/pexels-photo-1028674.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      date: DateTime.now(),
    ),
    RequestItem(
      id: '4',
      itemName: 'Soap and Shampoo',
      itemDescription:
          'Lorem Ipsum this is description. Add any item description or specifics here. I need to take bath pls give me.',
      userId: 'yaegerknight',
      imgUrl:
          'https://images.pexels.com/photos/545014/pexels-photo-545014.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      date: DateTime.now(),
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
}
