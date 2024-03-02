// import 'dart:' as http;

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>?> getLoginDetails() async {
  final prefs = await SharedPreferences.getInstance();

  var username = prefs.getString("username");
  var password = prefs.getString("password");

  if (username == null || password == null) {
    return null;
  } else {
    return [username , password];
  }
}


Future<void> setLoginDetails(String username, String password) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("username", username);
  prefs.setString("password", password);
}

