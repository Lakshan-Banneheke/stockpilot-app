import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockpilot_app/views/home/home.dart';
import 'package:stockpilot_app/views/root/root_bloc.dart';


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
          '/' : (context) => Home(),
          // '/navigationHome' : (context)  => SplashPage(),
          // '/navigation' : (context) => Navigation(),
          // '/web' : (context) => WebPage(),
          // '/login' : (context) => LoginUserProvider(),
        }
      ),
    );
  }
}

