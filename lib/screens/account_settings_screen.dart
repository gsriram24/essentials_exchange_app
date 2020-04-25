import 'package:flutter/material.dart';

class AccountSettingsScreen extends StatefulWidget {
  static const routeName = '/account-settings';

  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final _formKey1 = GlobalKey<FormState>();

  @override
  final FocusNode _nameFocus = FocusNode();

  final FocusNode _bioFocus = FocusNode();

  Widget get phoneNumberEntry {
    return Form(
      key: _formKey1,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              focusNode: _nameFocus,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
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
              focusNode: _bioFocus,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
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
              color: Theme.of(context).accentColor,
              child: Text(
                'Save',
                style: Theme.of(context).textTheme.button,
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
      body: Center(
        child: Container(
          width: double.infinity,
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
                              "https://www.searchpng.com/wp-content/uploads/2019/02/Deafult-Profile-Pitcher.png"),
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
                  child: phoneNumberEntry,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
