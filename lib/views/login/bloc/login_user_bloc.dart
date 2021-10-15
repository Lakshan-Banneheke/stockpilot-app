import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockpilot_app/models/user.dart';
import 'package:stockpilot_app/views/root/root_bloc.dart';
import 'package:stockpilot_app/views/root/root_event.dart';

import 'login_user_event.dart';
import 'login_user_state.dart';

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {
  final RootBloc rootBloc;

  LoginUserBloc(BuildContext context)
      : this.rootBloc = BlocProvider.of<RootBloc>(context),
        super(LoginUserState.initialState);

  @override
  Stream<LoginUserState> mapEventToState(LoginUserEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;

      case TogglePassEvent:
        yield state.clone(showPass: !state.showPass);
        break;

      case LoginEvent:
        yield state.clone(loading: true, loginFailed: false);
        final authDetails = (event as LoginEvent).auth;
        print('Email: ${authDetails['email']}');
        final user =
            await User.getFromAPI(authDetails['email'], authDetails['password']);
        print(user.token);
        if (user.token != null) {
          rootBloc.add(LogInUserEvent(authDetails, user));
        } else {
          yield state.clone(loading: false, loginFailed: true);
        }
        break;
    }
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    _addErr(error);
    super.onError(error, stacktrace);
  }

  @override
  Future<void> close() async {
    await super.close();
  }

  void _addErr(e) {
    if (e is StateError) return;
    try {
      add(ErrorEvent((e is String)
          ? e
          : (e.message ?? "Something went wrong. Please try again!")));
    } catch (e) {
      add(ErrorEvent("Something went wrong. Please try again!"));
    }
  }
}
