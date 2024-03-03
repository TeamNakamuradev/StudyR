import 'package:flutter/material.dart';
import 'package:studyr/screens/community.dart';
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
        return CommunityPage(
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
          ],
          communityName: '',
        );
      },
    );
  }
}
