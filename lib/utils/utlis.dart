// import 'dart:' as http;

// import 'package:flutter_session_jwt/flutter_session_jwt.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>?> getLoginDetails() async {
  final prefs = await SharedPreferences.getInstance();
  var token = prefs.getString("loginToken");

  // var details = await ;


  var username = prefs.getString("username");
  var password = prefs.getString("password");
  
  if (username == null || password == null) {
    return null;
  } else {
    return [username , password];
  }
}


Future<void> saveLoginDetails(String username, String password) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("username", username);
  prefs.setString("password", password);
}

