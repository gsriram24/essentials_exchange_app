import 'package:essentials_exchange/screens/login_screen.dart';
import 'package:essentials_exchange/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
    print(showSignIn.toString());
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn ? LoginScreen(toggleView) : SignupScreen(toggleView);
  }
}
