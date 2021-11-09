import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockpilot_app/models/hist_notification.dart';
import 'package:stockpilot_app/views/root/root_bloc.dart';

import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final RootBloc rootBloc;

  NotificationBloc(BuildContext context) : this.rootBloc = BlocProvider.of<RootBloc>(context),
        super(NotificationState.initialState);

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    switch (event.runtimeType) {
      case ErrorEvent:
        final error = (event as ErrorEvent).error;
        yield state.clone(error: "");
        yield state.clone(error: error);
        break;
      case AddNotificationEvent:
        final notif = (event as AddNotificationEvent).notif;
        List tempNotifs = [...state.notifications, notif];
        yield state.clone(notifications: tempNotifs);
        break;
      case GetHistNotifsEvent:
        yield state.clone(loading: true);
        String token = rootBloc.state.user.token;
        List<HistNotification> histNotifs = await HistNotification.getFromAPI(token);
        yield state.clone(histNotifs: histNotifs, loading: false);
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
      add(ErrorEvent((e is String) ? e : (e.message ?? "Something went wrong. Please try again!")));
    } catch (e) {
      add(ErrorEvent("Something went wrong. Please try again!"));
    }
  }
}
