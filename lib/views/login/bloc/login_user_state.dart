import 'package:flutter/material.dart';

@immutable
class LoginUserState {
  final String error;
  final bool showPass;
  final bool loginFailed;
  final bool loading;

  LoginUserState({
    @required this.error,
    @required this.showPass,
    @required this.loginFailed,
    @required this.loading,
  });

  static LoginUserState get initialState => LoginUserState(
        error: '',
        showPass: false,
        loginFailed: false,
        loading: false,
      );

  LoginUserState clone({
    String error,
    bool showPass,
    bool loginFailed,
    bool loading,
  }) {
    return LoginUserState(
      error: error ?? this.error,
      showPass: showPass ?? this.showPass,
      loading: loading ?? this.loading,
      loginFailed: loginFailed ?? this.loginFailed,
    );
  }
}
