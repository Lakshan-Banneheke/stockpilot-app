import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:stockpilot_app/constants.dart';
import 'package:stockpilot_app/views/notification/bloc/notification_event.dart';
import 'package:stockpilot_app/views/notification/bloc/notification_state.dart';
import 'package:stockpilot_app/views/root/root_bloc.dart';
import 'package:stockpilot_app/views/root/root_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/notification_bloc.dart';

class Notif extends StatefulWidget {
  @override
  _NotifState createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  String token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
    final notifBloc = BlocProvider.of<NotificationBloc>(context);

    notifBloc.add(GetHistNotifsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final rootBloc = BlocProvider.of<RootBloc>(context);


    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.kPrimary,
        title: Text('Notifications'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              rootBloc.add(LogOutEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        buildWhen: (previous, current) => previous.loading != current.loading,
        builder: (context, state) {
          return state.loading == false ?
              ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    var notif =  state.histNotifs[index];
                    return Card(
                      child: ListTile(
                        contentPadding: EdgeInsets.all(20),
                        title: Text(
                            notif.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                        ),
                        subtitle: Text(
                            notif.body,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                  // separatorBuilder: (context, index) => Divider(color: Colors.black38, thickness: 0.5),
                  itemCount: state.histNotifs.length

              )
              : Center( child: CircularProgressIndicator(),);
        }),
    );
  }

  getToken() async {
    token = (await FirebaseMessaging.instance.getToken());
    setState(() {
      token = token;
    });
    print(token);
  }
}
