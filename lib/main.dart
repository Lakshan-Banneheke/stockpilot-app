import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockpilot_app/views/home/home.dart';
import 'package:stockpilot_app/views/notification/bloc/notification_bloc.dart';
import 'package:stockpilot_app/views/root/root_bloc.dart';


///Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async{
  // print("BBBBBBBBBBBBBBBBBBBBBB");

  // print(message.data.toString());
  // print(message.notification.title);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(StockPilotApp());
}

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
          // '/test' : (context) => Test()
          // '/navigationHome' : (context)  => SplashPage(),
          // '/navigation' : (context) => Navigation(),
          // '/web' : (context) => WebPage(),
          // '/login' : (context) => LoginUserProvider(),
        }
      ),
    );
  }
}

