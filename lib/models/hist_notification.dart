import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../constants.dart';

class HistNotification{
  final DateTime datetime;
  final String title;
  final String body;

  HistNotification({
    @required this.datetime,
    @required this.title,
    @required this.body
  });

  static Future<List<HistNotification>> getFromAPI({String token, Dio dio_}) async {
    Dio dio = dio_ ?? Dio();
    var response;
    // dio.options.headers["x-access-token"] = token;
    print('Notification get from API called');
    try {
      //TODO header method changed for test. Check if this actually works after backend deployment
      response = await dio.get(Constants.notifHistUrl, options: Options(headers: {"x-access-token" : token}));
      List list = response.data["last 5 days notifications"];
      List<HistNotification> notifList = [];
      list.forEach((notif) {
        var datetime = DateTime.fromMillisecondsSinceEpoch(notif[0]);
        final notifDetails = notif[1];

        notifList.add(HistNotification(
          datetime: datetime,
          title: notifDetails['symbol'] + ' - ' + notifDetails['type'],
          body: 'Peak Price: ' + notifDetails['current peak price'].toString() + '\n' + 'Open Price: ' + notifDetails['open price'].toString()
        ));
      });
      return notifList;
    } on DioError catch (e) {
      log(e.response.toString());
      return [];
    }
  }






}
