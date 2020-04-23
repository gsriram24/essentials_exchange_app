import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  final Function toggleView;
  SignupScreen(this.toggleView);
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('SignupScreen'),
          onPressed: () {
            widget.toggleView();
          },
        ),
      ),
    );
  }
}
