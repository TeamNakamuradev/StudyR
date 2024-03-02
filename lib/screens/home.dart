import 'package:flutter/material.dart';
import 'package:studyr/utils/utlis.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var loginDetails = getLoginDetails();
    return const Scaffold(
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
