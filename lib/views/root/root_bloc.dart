import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stockpilot_app/models/user.dart';

import 'root_event.dart';
import 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {

  RootBloc(BuildContext context)
      : super(RootState.initialState) {
    _initialize();
  }

  Future<void> _initialize() async {
    Future.delayed(Duration(seconds: 2), () => add(CheckStartedEvent()));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email') ?? '');
    String password = (prefs.getString('password') ?? '');
    if (email.isNotEmpty) print('Saved User $email');
    if (email.isNotEmpty && password.isNotEmpty) {
      final user = await User.getFromAPI(email, password);
      if (user != null) {
        add(UpdateUserEvent(user));
        print('Logged In ${user.email}');
        await Future.delayed(Duration(seconds: 1));
        add(ChangeLogInStateEvent(LoginState.LOGIN));

      } else {
        await Future.delayed(Duration(seconds: 3));
        print('Deleted User');
        add(ChangeLogInStateEvent(LoginState.LOGOUT));
      }
    } else {
      print('No Saved User');
      await Future.delayed(Duration(seconds: 3));
      add(ChangeLogInStateEvent(LoginState.LOGOUT));
    }
  }

  @override
  Stream<RootState> mapEventToState(RootEvent event) async* {
    switch (event.runtimeType) {
      case ErrorRootEvent:
        final error = (event as ErrorRootEvent).error;
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;

      case UpdateUserEvent:
        final user = (event as UpdateUserEvent).user;
        yield state.clone(user: user);
        break;

      case CheckStartedEvent:
        yield state.clone(checkStarted: true);
        break;

      case ChangeLogInStateEvent:
        final stateLogin = (event as ChangeLogInStateEvent).state;
        yield state.clone(loginState: stateLogin);
        break;

      case LogOutEvent:
        yield state.clone(loginState: LoginState.LOGOUT);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', '');
        await prefs.setString('password', '');
        yield state.clone(loginState: LoginState.LOGOUT);
        print('User Logged Out');
        break;

      case LogInUserEvent:
        final auth = (event as LogInUserEvent).auth;
        final user = (event as LogInUserEvent).user;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', auth['user']);
        await prefs.setString('password', auth['password']);
        yield state.clone(
          loginState: LoginState.LOGIN,
          user: user,
        );
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
      add(ErrorRootEvent((e is String) ? e : (e.message ?? "Something went wrong. Please try again!")));
    } catch (e) {
      add(ErrorRootEvent("Something went wrong. Please try again!"));
    }
  }
}
