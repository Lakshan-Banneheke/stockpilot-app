
import 'package:flutter/material.dart';
import 'package:stockpilot_app/models/hist_notification.dart';

@immutable
class NotificationState {
  final String error;
  final List notifications;
  final List<HistNotification> histNotifs;
  final bool loading;

  NotificationState({
    @required this.error,
    @required this.notifications,
    @required this.histNotifs,
    @required this.loading
  });

  static NotificationState get initialState => NotificationState(
        error: '',
        notifications: [],
        histNotifs: [],
        loading: true,
      );

  NotificationState clone({
    String error,
    List notifications,
    List<HistNotification> histNotifs,
    bool loading,
  }) {
    return NotificationState(
      error: error ?? this.error,
      notifications: notifications ?? this.notifications,
      histNotifs: histNotifs ?? this.histNotifs,
      loading: loading ?? this.loading
    );
  }
}
