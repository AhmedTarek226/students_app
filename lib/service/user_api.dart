import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:students_app/models/user.dart';

class UserApi {
  Future<http.Response> Login(User user) async {
    Uri addURL = Uri.https("api.mohamed-sadek.com", "/User/login");
    // http.post(addURL, body: user).then((value) => print(value.statusCode)).onError((error, stackTrace) => null);
    Map<String, Object> data = {
      "UserName": user.UserName,
      "Password": user.Password
    };
    print("start");
    return http.post(addURL,
        body: jsonEncode(<String, String>{
          "UserName": user.UserName,
          "Password": user.Password
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }
}
