import 'package:flutter/material.dart';

@immutable
abstract class NotificationEvent {}

class ErrorEvent extends NotificationEvent {
  final String error;

  ErrorEvent(this.error);
}

class AddNotificationEvent extends NotificationEvent {
  final Object notif;

  AddNotificationEvent(this.notif);
}

class GetHistNotifsEvent extends NotificationEvent{
  GetHistNotifsEvent();
}