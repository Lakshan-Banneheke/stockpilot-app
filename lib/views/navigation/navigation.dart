import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:stockpilot_app/services/local_notification_service.dart';
import 'package:stockpilot_app/views/root/root_bloc.dart';
import 'package:stockpilot_app/views/root/root_event.dart';
import 'package:stockpilot_app/widgets/button_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  String token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    final rootBloc = BlocProvider.of<RootBloc>(context);

    return  Container(
        child: Column(
          children: [
            ButtonIcon(
              text: 'Log Out',
              onTap: () {
                rootBloc.add(LogOutEvent());
              },
            ),
          ],
        ),
      );
  }

  getToken() async {
    token = (await FirebaseMessaging.instance.getToken());
    setState(() {
      token = token;
    });
    print(token);
  }
}
