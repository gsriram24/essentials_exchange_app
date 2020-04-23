import 'package:essentials_exchange/wrappers/auth_homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import './providers/requestItems.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Requests(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          accentColor: Colors.blueAccent[100],
          textTheme: TextTheme().copyWith(
            display1: TextStyle(
              fontSize: 50.0,
            ),
          ),
        ),
        routes: {
          '/': (_) => Wrapper(),
        },
      ),
    );
  }
}
