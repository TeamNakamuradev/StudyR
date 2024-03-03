// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:studyr/chat/chatbot.dart';
import 'package:studyr/screens/swipe_page.dart';
import 'package:studyr/utils/hex.dart';
import 'package:studyr/utils/swiper.dart';
import 'package:studyr/screens/notes_screen.dart';

final List<StudySession> sessions = [
    StudySession(sessionName: "Session1",sessionID: "sessionID", members: ["User1"], topics: ["topics"]),
    StudySession(sessionName: "Session2",sessionID: "sessionID", members: ["User2"], topics: ["topics"]),
    StudySession(sessionName: "Session3",sessionID: "sessionID", members: ["User3"], topics: ["topics"])
  ];

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

class CommunityPage extends StatefulWidget {
  final List<Community> communities;

  CommunityPage({required this.communities, required String communityName});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int currentPageIndex = 0;
  
  var communities = [
    Community(id: '1', name: 'Community 1', users: ['User1', 'User2']),
    Community(id: '2', name: 'Community 2', users: ['User3', 'User4']),
    Community(id: '3', name: 'Community 3', users: ['User5', 'User6']),
    Community(id: '4', name: 'Community 4', users: ['User7', 'User8']),
    Community(id: '5', name: 'Community 5', users: ['User9', 'User10']),


  ];

  @override
  void initState() {
    
    super.initState();
    currentPageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            if(index==2){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotesScreen(),
                ),
              );
            }
          });
        },
        indicatorColor: Color.fromARGB(255, 105, 160, 244),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_rounded),
            label: 'ChatBot',
          ),
          NavigationDestination(icon: Icon(Icons.notes), label: 'Notes'),
        ],
      ),
      appBar: AppBar(
        title: Text('Communities Page'),
      ),
      body: [CommunityList(), ChatView()][currentPageIndex],
    );
  }

  ListView CommunityList() {
    return ListView.builder(
      itemCount: widget.communities.length - 2 ,
      itemBuilder: (context, index) {
        return Card(
          color: HexColor('#9faee9'), 
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Swiper(sessions: sessions),
                ),
              );
            },
            child: Stack(
              children: [
               
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
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/info');
                                  },
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
      );
    
  }
}
