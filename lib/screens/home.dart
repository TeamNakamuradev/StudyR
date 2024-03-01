import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studyr/main.dart';
import 'package:studyr/utils/hex.dart';

class Dashboard extends StatefulWidget {
  static String routeName = '/home';
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final idController =
      TextEditingController(); // Create a controller for the username
  final pwdController =
      TextEditingController(); // Create a controller for the password
  @override
  void dispose() {
    idController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}
