import 'package:flutter/material.dart';
import 'package:stockpilot_app/views/root/root_bloc.dart';
import 'package:stockpilot_app/views/root/root_event.dart';
import 'package:stockpilot_app/widgets/button_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

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
}
