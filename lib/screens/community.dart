import 'package:flutter/material.dart';
import 'package:studyr/screens/swipe_page.dart';
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
            child: InkWell(
             onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SwipePage(title: communities[index].name, community: communities[index]),
    ),
  );
},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Community Name: ${communities[index].name}'),
                    Text('Community ID: ${communities[index].id}'),
                    Text('Users: ${communities[index].users.join(', ')}'),
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.info),
                              onPressed: () {
                               
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.leaderboard),
                              onPressed: () {
                        Navigator.pushNamed(context, '/leaderboard');
                      },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

