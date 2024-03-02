import 'package:flutter/material.dart';
import 'package:studyr/screens/dashboard.dart';
import 'package:studyr/screens/home.dart';
import 'package:studyr/screens/login.dart';
import 'package:studyr/screens/signup.dart';
import 'package:studyr/screens/viewer.dart';
import 'color_schemes.g.dart';

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
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      routes: {
        '/home': (context) => Home(),
        '/pdfviewer': (context) => PDFViewer(
              pdfUrl:
                  'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
            ),
        '/dashboard': (context) => Builder(
              builder: (BuildContext context) =>
                  DashboardPage(userName: 'John Doe'),
            ),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
      },
      initialRoute: '/login',
    );
  }
}
