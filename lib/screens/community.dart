import 'package:flutter/material.dart';
import 'package:studyr/screens/swipe_page.dart';
import 'package:studyr/utils/hex.dart';

class Community {
  final String id;
  final String name;
  final List<String> users;

  Community({
    required this.id,
    required this.name,
    required this.users,
  });
}

class CommunityPage extends StatelessWidget {
  final List<Community> communities;

  CommunityPage({required this.communities, required String communityName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Communities Page'),
      ),
      body: ListView.builder(
        itemCount: communities.length,
        itemBuilder: (context, index) {
          return Card(
            color: HexColor('#9faee9'), // Add your desired color here
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SwipePage(
                      title: communities[index].name,
                      community: communities[index],
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  // Background image

                  // Content on top of the image
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${communities[index].name}',
                            style:
                                TextStyle(fontSize: 28, color: Colors.white)),
                        // Text('Community ID: ${communities[index].id}',
                        //     style:
                        //         TextStyle(fontSize: 16, color: Colors.white)),
                        // Text('Users: ${communities[index].users.join(', ')}',
                        //     style:
                        //         TextStyle(fontSize: 16, color: Colors.white)),
                        Row(
                          children: [
                            Expanded(child: Container()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.info),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.leaderboard),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/leaderboard');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
