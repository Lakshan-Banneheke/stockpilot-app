import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockpilot_app/views/root/root_bloc.dart';
import 'package:stockpilot_app/views/root/root_state.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RootBloc, RootState>(
        listenWhen: (previous, current) => previous.loginState != current.loginState,
        listener: (context, state) {
          print('Login State > ${state.loginState}');
          if (state.loginState == LoginState.LOGOUT) {
            Navigator.pushReplacementNamed(context, '/login');
          } else if (state.loginState == LoginState.LOGIN) {
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        buildWhen: (previous, current) => previous.checkStarted != current.checkStarted,
        builder: (context, state) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 170,
                      width: 170,
                    ),
                  ),
                  SizedBox(height: 20),
                  state.checkStarted ? Center(child: CircularProgressIndicator()) : SizedBox(height: 36)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
