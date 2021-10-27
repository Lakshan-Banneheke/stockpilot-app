import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockpilot_app/views/login/bloc/login_user_provider.dart';
import 'package:stockpilot_app/views/notification/bloc/notification_provider.dart';
import 'package:stockpilot_app/views/notification/notif.dart';
import 'package:stockpilot_app/views/root/root_bloc.dart';
import 'package:stockpilot_app/views/root/root_state.dart';
import 'package:stockpilot_app/widgets/loader.dart';

class NotifHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<RootBloc, RootState>(
        buildWhen: (previous, current) => previous.checkStarted != current.checkStarted || previous.loginState != current.loginState,
        builder: (context, state) {
          print(state.loginState);
          if (state.loginState != LoginState.CHECKING) {
            print('Login State > ${state.loginState}');
            if (state.loginState == LoginState.LOGOUT) {
              return LoginUserProvider();
            } else if (state.loginState == LoginState.LOGIN) {
              return NotificationProvider();
            } else {
              return LoginUserProvider();
            }
          } else {
            return Loader();
          }
        },

      ),
    );
  }
}
// state.checkStarted ? Loader();