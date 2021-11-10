import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stockpilot_app/views/notification/notifHome.dart';
import 'package:stockpilot_app/views/web/webPage.dart';


class HomeWidget extends StatefulWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _currentIndex = 0;
  final List _children = [
    WebPage(),
    NotifHome()
  ];

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
              icon: Icon(FontAwesomeIcons.solidBell),
              label: 'Notifications',
            ),

          ],
        ),
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
