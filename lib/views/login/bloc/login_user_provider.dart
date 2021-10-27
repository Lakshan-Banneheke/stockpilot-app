import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockpilot_app/views/root/root_bloc.dart';
import 'package:stockpilot_app/views/root/root_state.dart';

import '../loginUser.dart';
import 'login_user_bloc.dart';
import 'login_user_state.dart';

class LoginUserProvider extends BlocProvider<LoginUserBloc> {
  LoginUserProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => LoginUserBloc(context),
          child: LoginView(),
        );
}

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginUserBloc, LoginUserState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error?.isNotEmpty ?? false) print("ERROR: ${state.error}");
          },
        ),
        BlocListener<RootBloc, RootState>(
          listenWhen: (pre, current) => pre.loginState != current.loginState,
          listener: (context, state) {
            if (state.loginState == LoginState.LOGIN)
              //TODO CHECK THIS
              Navigator.pushReplacementNamed(context, '/web');
          },
        ),
      ],
      child: UserLoginPage(),
    );
  }
}
