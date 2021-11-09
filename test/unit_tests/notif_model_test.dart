import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stockpilot_app/constants.dart';
import 'package:stockpilot_app/models/hist_notification.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final client = MockDio();
  final token = "sample_token";
  when(client.get(any, options: anyNamed('options')))
      .thenAnswer((_) async =>
      Response(data:
      {"last 5 days notifications" : [[
        1636453314000,
        {"message": "successful", "type": "Over 75 percent decriment", "symbol": "BNBUSDT",
        "open price": 500, "current peak price": 550}
        ]]} ,
          statusCode: 200, requestOptions: null));


  test('API call occurs in Notification', () async {
    //launch
    await HistNotification.getFromAPI(token : token, dio_: client);

    //verify
    verify(client.get(
      Constants.notifHistUrl,
        options: anyNamed('options')))
        .called(1);

  });

  test('Notif list is created', () async {
    //launch
    List<HistNotification> notifList = await HistNotification.getFromAPI(token : token, dio_: client);

    expect(notifList[0].datetime, DateTime.fromMillisecondsSinceEpoch(1636453314000));
    expect(notifList[0].title, 'BNBUSDT - Over 75 percent decriment');
    expect(notifList[0].body, 'Peak Price: ' + '550' + '\n' + 'Open Price: ' + '500');

  });
}
