import 'package:badges/badges.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stockpilot_app/constants.dart';
import 'package:stockpilot_app/services/local_notification_service.dart';
import 'package:stockpilot_app/views/notification/notifHome.dart';
import 'package:stockpilot_app/views/web/webPage.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int notifCounter = 1;
  int _currentIndex = 0;
  final List _children = [
    WebPage(),
    NotifHome()
  ];

  @override
  void initState() {
    super.initState();

    LocalNotificationService.initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {

    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification != null){
        print("AAAAAAAAAAAAAAAAAAAAAAA");
        // print(message.notification.body);
        // print(message.notification.title);
        // print(message.data['data']);
      }

      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            switchInCurve: Curves.ease,
            switchOutCurve: Curves.ease,
            transitionBuilder: (child, animation) {
              final offsetAnimation = Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0)).animate(animation);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            layoutBuilder: (currentChild, previousChildren) => currentChild,
            child: _children[_currentIndex]
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped, // new
          currentIndex: _currentIndex, // new
          items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              // icon: Icon(FontAwesomeIcons.solidBell),
              // icon: NotifIcon(),
              icon: Badge(
                showBadge: notifCounter == 0 ? false : true,
                badgeColor : Constants.kSecondary,
                badgeContent: Text('$notifCounter'),
                child: Icon(FontAwesomeIcons.solidBell),
              ),
              label: 'Notifications',
            ),

          ],
        ),
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      if (index == 1){
        notifCounter = 0;
      }
      _currentIndex = index;
    });
  }
}
