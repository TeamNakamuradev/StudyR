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

import 'package:flutter/material.dart';

class CommunityInfoPage extends StatelessWidget {
  final List<Map<String, dynamic>> communities = [
    {
      'name': 'Computer Science',
      'description':
          'A community for computer science enthusiasts. Share your knowledge, ask questions, and discuss the latest trends in computer science.',
      'admin': ['AdminUser1'],
      'users': ['User1', 'User2', 'User3'],
      'sessions': [
        {'name': 'Session1'},
        {'name': 'Session2'},
        {'name': 'Session3'},
        {'name': 'Session4'},
        {'name': 'Session5'},
        {'name': 'Session6'}
      ],
      'icon': Icons.computer,
    },
    {
      'name': 'Number Navigators',
      'description':
          'A community for mathematics enthusiasts. Explore the beauty of numbers, solve challenging problems, and discuss mathematical concepts with like-minded individuals.',
      'admin': ['AdminUser2'],
      'users': ['User4', 'User5'],
      'icon': Icons.calculate,
    },
    {
      'name': 'Physics Enthusiasts',
      'description':
          'A community for those passionate about the study of matter, energy, and the interaction between them.',
      'admin': ['AdminUser3'],
      'users': ['User6', 'User7'],
      'icon': Icons.science,
    },
    {
      'name': 'Biology Buffs',
      'description': 'A community for biology enthusiasts.',
      'admin': ['AdminUser4'],
      'users': ['User8', 'User9'],
      'icon': Icons.bug_report,
    },
    {
      'name': 'Chemistry Club',
      'description':
          'A community for those interested in the study of the properties and behaviors of matter.',
      'admin': ['AdminUser5'],
      'users': ['User10', 'User11'],
      'icon': Icons.science,
    },
    {
      'name': 'Astronomy Admriers',
      'description':
          'A community for those fascinated by the study of celestial objects, space, and the physical universe.',
      'admin': ['AdminUser6'],
      'users': ['User12', 'User13'],
      'icon': Icons.nights_stay,
    },
    {
      'name': 'cultural clubs',
      'description':
          'A community for cultural enthusiasts. Join us to celebrate and share cultural diversity through various events, discussions, and activities.',
      'admin': ['AdminUser7'],
      'users': ['User14', 'User15'],
      'icon': Icons.emoji_events,
    }
  ];

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
      body: ListView.builder(
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
