import 'package:flutter/material.dart';
import 'package:stockpilot_app/views/root/root_bloc.dart';
import 'package:stockpilot_app/views/root/root_event.dart';
import 'package:stockpilot_app/widgets/button_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    final rootBloc = BlocProvider.of<RootBloc>(context);

    return SafeArea(
        child: Scaffold(
          body: Container(
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
          )
        )
    );
  }
}
