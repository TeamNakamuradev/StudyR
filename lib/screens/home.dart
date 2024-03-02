import 'package:flutter/material.dart';
import 'package:studyr/utils/utlis.dart';
import 'package:studyr/screens/login.dart';
// import 'paclage:studyr/screens/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var loginDetails = getLoginDetails();

    return FutureBuilder(
      future: loginDetails,
      builder: (context, snap) {
        if (snap.data == null) {
          return LoginPage();
        }
        return const Scaffold(
          body: Center(
            child: Text('Welcome to StudyR'),
          ),
        );
        
      },
    );
  }
}
