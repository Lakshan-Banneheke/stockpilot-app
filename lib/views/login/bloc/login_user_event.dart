import 'package:flutter/material.dart';

@immutable
abstract class LoginUserEvent {}

class ErrorEvent extends LoginUserEvent {
  final String error;

  ErrorEvent(this.error);
}

class TogglePassEvent extends LoginUserEvent {}

class LoginEvent extends LoginUserEvent {
  final Map<String, String> auth;

  LoginEvent(this.auth);
}
