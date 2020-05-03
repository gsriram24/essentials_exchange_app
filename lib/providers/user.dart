import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String bio;
  final String imgUrl;

  UserData({this.uid, this.name, this.bio, this.imgUrl});

  Future<void> addUserToDB() async {
    var response = await http.put(
      'https://essentials-exchange.firebaseio.com/users/$uid.json',
      body: json.encode(
        {
          'user_id': this.uid,
          'name': this.name,
          'bio': this.bio,
          'imgUrl': null,
        },
      ),
    );
  }

  static Future<UserData> fetchUserData(String uid) async {
    var response = await http
        .get('https://essentials-exchange.firebaseio.com/users/$uid.json');
    var extractedData = json.decode(response.body);
    return UserData(
      uid: extractedData['user_id'],
      name: extractedData['name'],
      bio: extractedData['bio'],
      imgUrl: extractedData['imgUrl'],
    );
  }
}
