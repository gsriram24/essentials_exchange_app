import 'package:essentials_exchange/providers/auth.dart';
import 'package:essentials_exchange/screens/account_settings_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Account Settings'),
            onTap: () {
              Navigator.of(context).pushNamed(AccountSettingsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
