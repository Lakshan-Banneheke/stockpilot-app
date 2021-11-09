import 'package:dio/dio.dart';

import '../constants.dart';

class User{
  String email;
  String password;
  String token;

  User(
      this.email,
      this.password,
      this.token
  );

  static Future<User> getFromAPI({String email, String password, Dio dio_}) async {
    Dio dio = dio_ ?? Dio();
    print('User get from API called');

    try {
      Response response = await dio.post(
        Constants.loginUrl,
        data: {"creds" : {"email": email, "password": password}},
      );
      final data = response.data;
      return User(
        email,
        password,
        data['token'],
      );
    } on DioError catch (e) {
      print(e.toString());
      return null;
    }
  }
}