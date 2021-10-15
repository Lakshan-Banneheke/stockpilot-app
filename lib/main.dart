import 'package:flutter/material.dart';
import 'package:stockpilot_app/splash.dart';
import 'package:stockpilot_app/views/home/home.dart';


void main() => runApp(StockPilotApp());


class StockPilotApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.light,
        initialRoute: '/',
        routes: {
          '/' : (context)  => SplashPage(),
          '/home' : (context) => Home(),
        }
    );
  }
}

