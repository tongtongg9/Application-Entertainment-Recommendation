import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:my_finalapp1/model/Connectapi.dart';

import 'Connectapi.dart';

class LoginOwModel {
  LoginOwModel();

  Future<http.Response> doLoginOw(var username, var password) async {
    var url = '${Connectapi().domain}/loginowner';
    var body = {
      "username": username,
      "password": password,
    };

    return http.post(Uri.parse(url), body: body);
  }
}