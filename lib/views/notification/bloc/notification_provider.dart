import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../notif.dart';
import 'notification_bloc.dart';
import 'notification_state.dart';

class NotificationProvider extends BlocProvider<NotificationBloc> {
  NotificationProvider({
    Key key,
  }) : super(
          key: key,
          create: (context) => NotificationBloc(context),
          child: NotificationView(),
        );
}

class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks

    return MultiBlocListener(
      listeners: [
        BlocListener<NotificationBloc, NotificationState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error?.isNotEmpty ?? false) print("ERROR: ${state.error}");
          },
        ),
      ],
      child: Notif(),
    );
  }
}
