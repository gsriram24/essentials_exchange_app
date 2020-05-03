import 'package:essentials_exchange/providers/auth.dart';
import 'package:essentials_exchange/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountSettingsScreen extends StatefulWidget {
  static const routeName = '/account-settings';

  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final _formKey1 = GlobalKey<FormState>();
  final FocusNode _nameFocus = FocusNode();

  final FocusNode _bioFocus = FocusNode();

  var _isInit = true;
  var _isLoading = false;
  var userData;
  @override
  void didChangeDependencies() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      UserData.fetchUserData(uid).then((value) {
        setState(() {
          _isLoading = false;
          userData = value;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget get userEntry {
    return Form(
      key: _formKey1,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              initialValue: userData.name,
              focusNode: _nameFocus,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full Name',
              ),
              textInputAction: TextInputAction.next,
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(_bioFocus),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter a Name!';
                }
                return null;
              },
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              initialValue: userData.bio,
              focusNode: _bioFocus,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Bio',
              ),
              maxLines: 3,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter a Bio';
                }
                return null;
              },
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              onPressed: () {
                if (_formKey1.currentState.validate()) {}
              },
              child: Text(
                'Save',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Settings',
        ),
      ),
      body: _isLoading || userData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 30),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 150.0,
                            height: 150.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: new NetworkImage(
                                  userData.imgUrl != null
                                      ? userData.imgUrl
                                      : "https://www.searchpng.com/wp-content/uploads/2019/02/Deafult-Profile-Pitcher.png",
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black54,
                            ),
                          ),
                          IconButton(
                            iconSize: 30,
                            onPressed: () {},
                            icon: Icon(Icons.edit),
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Container(
                        width: 300,
                        child: userEntry,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
