import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockpilot_app/splash.dart';
import 'package:stockpilot_app/views/home/home.dart';
import 'package:stockpilot_app/views/login/bloc/login_user_provider.dart';
import 'package:stockpilot_app/views/root/root_bloc.dart';
import 'package:stockpilot_app/views/web/webPage.dart';


void main() => runApp(StockPilotApp());


class StockPilotApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<RootBloc>(
          create: (context) => RootBloc(context),
          ),
        ],
      child : MaterialApp(
        themeMode: ThemeMode.light,
        initialRoute: '/',
        routes: {
          '/' : (context)  => SplashPage(),
          '/home' : (context) => Home(),
          '/web' : (context) => WebPage(),
          '/login' : (context) => LoginUserProvider(),
        }
      ),
    );
  }
}

