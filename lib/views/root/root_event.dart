import 'package:flutter/material.dart';
import 'package:stockpilot_app/models/user.dart';
import 'package:stockpilot_app/views/root/root_state.dart';

@immutable
abstract class RootEvent {}

class ErrorRootEvent extends RootEvent {
  final String error;
  ErrorRootEvent(this.error);
}

class UpdateUserEvent extends RootEvent {
  final User user;
  UpdateUserEvent(this.user);
}

class ChangeLogInStateEvent extends RootEvent {
  final LoginState state;
  ChangeLogInStateEvent(this.state);
}

class LogOutEvent extends RootEvent {}

class LogInUserEvent extends RootEvent {
  final Map<String, String> auth;
  final User user;
  LogInUserEvent(this.auth, this.user);
}

class CheckStartedEvent extends RootEvent {}

class RefreshUserEvent extends RootEvent {}
