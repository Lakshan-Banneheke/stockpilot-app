import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stockpilot_app/constants.dart';
import 'package:stockpilot_app/models/user.dart';

class MockDio extends Mock implements Dio {}

void main() {
  final client = MockDio();
  when(client.post(any, data: anyNamed('data')))
      .thenAnswer((_) async =>
      Response(data: {"token" : 'sample_token'} , statusCode: 200, requestOptions: null));


  test('API call occurs in User', () async {
      //launch
      await User.getFromAPI(email: 'a@gmail.com', password: 'abcd', dio_: client);

      //verify
      verify(client.post(
        Constants.loginUrl,
        data: {"creds" : {"email": 'a@gmail.com', "password": 'abcd'}},
        )).called(1);

  });

  test('User object is created', () async {
    //launch
    final user = await User.getFromAPI(email: 'a@gmail.com', password: 'abcd', dio_: client);

    expect(user.email, 'a@gmail.com');
    expect(user.password, 'abcd');
    expect(user.token, 'sample_token');

  });
}
