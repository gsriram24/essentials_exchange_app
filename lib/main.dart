import 'package:essentials_exchange/providers/auth.dart';
import 'package:essentials_exchange/providers/user.dart';
import 'package:essentials_exchange/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:essentials_exchange/screens/account_settings_screen.dart';
import 'package:essentials_exchange/screens/add_request_screen.dart';
import 'package:essentials_exchange/wrappers/auth_homepage.dart';

import './providers/requestItems.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          value: AuthService().user,
        ),
        ChangeNotifierProvider.value(
          value: Requests(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        routes: {
          '/': (_) => Wrapper(),
          AccountSettingsScreen.routeName: (_) => AccountSettingsScreen(),
          AddRequestScreen.routeName: (_) => AddRequestScreen(),
          ChatScreen.routeName: (_) => ChatScreen(),
        },
      ),
    );
  }
}
