import 'dart:ffi';

import 'package:flutter/material.dart';

@immutable
class NotificationState {
  final String error;
  final List notifications;

  NotificationState({
    @required this.error,
    @required this.notifications,

  });

  static NotificationState get initialState => NotificationState(
        error: '',
        notifications: []
      );

  NotificationState clone({
    String error,
    List notifications,
  }) {
    return NotificationState(
      error: error ?? this.error,
      notifications: notifications ?? this.notifications,
    );
  }
}
