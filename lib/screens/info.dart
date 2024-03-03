// import 'package:flutter/material.dart';

// class CommunityInfoPage extends StatelessWidget {
//   final List<Map<String, dynamic>> communities = [
//     {
//       'name': 'Computer Science',
//       'description': 'A community for computer science enthusiasts.',
//       'admin': ['AdminUser1'],
//       'users': ['User1', 'User2', 'User3'],
//       'sessions': [
//         {'name': 'Session1'},
//         {'name': 'Session2'},
//       ],
//     },
//     {
//       'name': 'Mathematics',
//       'description': 'A community for mathematics enthusiasts.',
//       'admin': ['AdminUser2'],
//       'users': ['User4', 'User5'],
//       'sessions': [
//         {'name': 'Session3'},
//         {'name': 'Session4'},
//       ],
//     },

//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Community Info'),
//       ),
//       body: ListView.builder(
//         itemCount: communities.length,
//         itemBuilder: (context, index) {
//           final community = communities[index];
//           return Card(
//             elevation: 3,
//             margin: EdgeInsets.all(8),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     community['name'],
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text('Description: ${community['description']}'),
//                   SizedBox(height: 8),
//                   Text('Admins: ${community['admin'].join(', ')}'),
//                   SizedBox(height: 8),
//                   Text('Users: ${community['users'].join(', ')}'),
//                   SizedBox(height: 8),
//                   Text('Sessions:'),
//                   Column(
//                     children: (community['sessions'] as List<Map<String, dynamic>>)
//                         .map((session) => Padding(
//                               padding: const EdgeInsets.only(left: 16.0),
//                               child: Text(session['name']),
//                             ))
//                         .toList(),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: CommunityInfoPage(),
//   ));
// }

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studyr/config.dart';

class CommunityInfoPage extends StatefulWidget {
  @override
  _CommunityInfoPageState createState() => _CommunityInfoPageState();
}

class _CommunityInfoPageState extends State<CommunityInfoPage> {
  List<Map<String, dynamic>> communities = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<String> getTokenFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('logintoken') ?? '';
  }

  Future<void> fetchData() async {
    try {
      var token = await getTokenFromLocalStorage();
      var communityIds = await getCommunityIds(token);

      for (var id in communityIds) {
        var communityInfo = await getCommunityInfo(id);
        communities.add(communityInfo);
      }

      // Update the UI after fetching the data
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<List<String>> getCommunityIds(String token) async {
    var url = Uri.parse('$server_url/user/info');
    print(token);
    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['communities'];
    } else {
      throw Exception(jsonDecode(response.body));
    }
  }

  Future<Map<String, dynamic>> getCommunityInfo(String id) async {
    var url = Uri.parse('http://$server_url/community/info/$id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load community info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Community Info',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: communities.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: communities.length,
              itemBuilder: (context, index) {
                final community = communities[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(community['icon'] ?? Icons.category),
                            SizedBox(width: 8),
                            Text(
                              community['name'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('Description: ${community['description']}'),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.supervised_user_circle),
                            SizedBox(width: 4),
                            Text('Admins: ${community['admin'].join(', ')}'),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.people),
                            SizedBox(width: 4),
                            Text('Users: ${community['users'].join(', ')}'),
                          ],
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CommunityInfoPage(),
    debugShowCheckedModeBanner: false,
  ));
}
