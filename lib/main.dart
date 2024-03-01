import 'package:flutter/material.dart';
import 'package:studyr/screens/home.dart';
import 'package:studyr/screens/viewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/home': (context) => Dashboard(),
        '/pdfviewer': (context) => pdfviewer(),
      },
      initialRoute: '/home',
    );
  }
}
