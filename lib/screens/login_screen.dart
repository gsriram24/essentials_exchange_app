import 'package:essentials_exchange/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  LoginScreen(this.toggleView);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  final AuthService _auth = AuthService();
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
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
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
            SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
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
                  dynamic result =
                      await _auth.signInWithEmailAndPassword(email, password);
                  if (result == null) {
                    print('Error');
                  }
                }
              },
              color: Theme.of(context).accentColor,
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
            FlatButton(
              onPressed: () {
                widget.toggleView();
              },
              child: Text(
                'Don\'t have an account? Signup',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Login',
              style: Theme.of(context).textTheme.display1,
            ),
            Container(
              width: 300,
              height: 400,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 7,
                child: emailEntry,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
