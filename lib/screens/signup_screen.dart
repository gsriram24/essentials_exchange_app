import 'package:essentials_exchange/providers/auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  final Function toggleView;
  SignupScreen(this.toggleView);
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthService _auth = AuthService();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _bioFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  String fullName;
  String bio;
  String email;
  String password;
  Widget get emailEntry {
    return Form(
      key: _formKey1,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextFormField(
              focusNode: _nameFocus,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full Name',
              ),
              onChanged: (value) {
                fullName = value;
              },
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
            TextFormField(
              focusNode: _bioFocus,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Bio',
              ),
              onChanged: (value) {
                bio = value;
              },
              maxLines: 3,
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(_phoneFocus),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please Enter a Bio';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              onChanged: (value) {
                email = value;
              },
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                Pattern pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regex = new RegExp(pattern);

                if (value.isEmpty) {
                  return 'Please Enter your Email';
                }
                if (!regex.hasMatch(value)) {
                  return 'Enter a valid Email.';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              onPressed: () async {
                if (_formKey1.currentState.validate()) {
                  dynamic result = await _auth.registerWithEmailAndPassword(
                      email, password, fullName, bio, null);
                  if (result == null) {
                    print('error');
                  }
                }
              },
              color: Theme.of(context).accentColor,
              child: Text(
                'Signup',
                style: TextStyle(color: Colors.white),
              ),
            ),
            FlatButton(
              onPressed: () {
                widget.toggleView();
              },
              child: Text(
                'Have an account? Login',
                style: Theme.of(context).textTheme.button,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 30),
              Text(
                'Signup',
                style: Theme.of(context).textTheme.display1,
              ),
              SizedBox(height: 30),
              Container(
                width: 300,
                height: 500,
                child: emailEntry,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
