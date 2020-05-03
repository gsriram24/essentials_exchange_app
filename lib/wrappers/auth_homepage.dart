import 'package:essentials_exchange/providers/user.dart';
import 'package:essentials_exchange/screens/view_requests_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_signup.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return ViewRequestsScreen();
    }
  }
}
