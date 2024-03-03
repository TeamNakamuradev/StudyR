// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:studyr/screens/community.dart';
import 'package:studyr/screens/home.dart';
import 'package:studyr/screens/info.dart';
import 'package:studyr/screens/leaderboard.dart';
import 'package:studyr/screens/login.dart';
import 'package:studyr/screens/signup.dart';
import 'color_schemes.g.dart';
import 'package:studyr/utils/swiper.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final List<StudySession> sessions = [
    StudySession(sessionName: "sessionName",sessionID: "sessionID", members: ["members"], topics: ["topics"]),
    StudySession(sessionName: "sessionName",sessionID: "sessionID", members: ["members"], topics: ["topics"]),
    StudySession(sessionName: "sessionName",sessionID: "sessionID", members: ["members"], topics: ["topics"]),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      routes: {
        '/home': (context) => Home(),
        // '/dashboard': (context) => Builder(
        //       builder: (BuildContext context) =>
        //           DashboardPage(userName: 'John Doe'),
        //     ),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/info_dummy': (context) => CommunityInfoPage(),
        '/leaderboard': (context) => LeaderboardPage(
  users: [
    User(name: 'User1', score: 100),
    User(name: 'User2', score: 200),
    User(name: 'User3', score: 3000),
    User(name: 'User4', score: 400),
    User(name: 'User5', score: 500),
  ],
),

       '/community': (context) => CommunityPage(
  communities: [
    Community(
      id: '11',
      name: 'Computer Science',
      users: ['User1', 'User2', 'User3'],
     
    ),
    Community(
      id: '22',
      name: 'Mathematics',
      users: ['User4', 'User5', 'User6'],
  
    ),
    Community(
      id: '33',
      name: 'Physics',
      users: ['User7', 'User8', 'User9'],
  
    ),
    Community(
      id: '44',
      name: 'Biology',
      users: ['User10', 'User11', 'User12'],
  
    ),
    
  ], communityName: '',
),
        '/info':(context) => CommunityInfoPage()
      },
      initialRoute: '/community',
    );
  }
}
