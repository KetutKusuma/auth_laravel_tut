import 'dart:convert';

import 'package:auth_laravel_tut/services/globals.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  static Future<http.Response> register(
      String name, String email, String password) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
    };

    var body = jsonEncode(data);
    var url = Uri.parse('${baseURLIos}auth/registah');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> login(String email, String password) async {
    Map data = {
      "email": email,
      "password": password,
    };
    var body = jsonEncode(data);
    var url = Uri.parse('${baseURLIos}auth/login');
    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }
}
