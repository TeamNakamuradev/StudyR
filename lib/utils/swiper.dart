// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:swipe_cards/swipe_cards.dart';

import 'package:studyr/chat/userChat.dart';

class StudySession {
  StudySession({
    required this.sessionName,
    required this.sessionID,
    required this.members,
    required this.topics,
  });
  final String sessionID;
  final String sessionName;
  final List<String> topics;
  final List<String> members;
}

class Swiper extends StatefulWidget {
  const Swiper({
    super.key,
    required this.sessions,
  });
  final List<StudySession> sessions;
  @override
  State<Swiper> createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  List<SwipeItem> _swipeItems = [];
  late MatchEngine _matchEngine;
  List<Color> _colors = [
      
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.orange
    ];
  late List<StudySession> sampleSessions = [
    StudySession(
      sessionID: '1',
      sessionName: 'Number Navigator',
      topics: ['Algebra', 'Geometry', 'Calculus'],
      members: ['Alice', 'Bob', 'Charlie', 'David'],
    ),
    StudySession(
      sessionID: '2',
      sessionName: 'Flutter Workshop',
      topics: ['Widgets', 'State Management', 'Animations'],
      members: ['Eva', 'Frank', 'Grace', 'Henry'],
    ),
    StudySession(
      sessionID: '3',
      sessionName: 'History Club',
      topics: ['Ancient Civilizations', 'World Wars', 'Modern History'],
      members: ['Ivy', 'Jack', 'Katie', 'Liam'],
    ),
    StudySession(
      sessionID: '4',
      sessionName: 'Cultural Club',
      topics: ['Languages', 'Cuisine', 'Traditions'],
      members: ['kateryna', 'Jack', 'Katie', 'Liam'],
    ),
    StudySession(
      sessionID: '5',
      sessionName: 'Biology Buffs',
      topics: ['Mutations', 'Genetics', 'Evolution'],
      members: ['catherine', 'Jack', 'Katie', 'Liam'],
    ),
    StudySession(
      sessionID: '6',
      sessionName: 'Physics Pals',
      topics: ['Quantum Mechanics', 'Relativity', 'Astrophysics'],
      members: ['alex', 'Jack', 'Katie', 'Liam'],
    ),
   
  ];
  int _currentColorIndex = 0;
  @override
  void initState() {
    super.initState();


    
    for (int i = 0; i < widget.sessions.length; i++) {
      _swipeItems.add(SwipeItem(
          content: widget.sessions[i],
          likeAction: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return UserChatView();
              }),
            );
          },
          nopeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Nope "),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Superliked "),
              duration: Duration(milliseconds: 500),
            ));
          },
          onSlideUpdate: (region) async {
            print("Region $region");
          },
          
          ));

      var members = widget.sessions[i].members.map((item) {
        return Container(
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
                endIndent: 5,
              )
            ],
          ),
        );
      }).toList();
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

 Color getCurrentColor() {
    return _colors[_currentColorIndex];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ongoing Sessions"),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 40),
        child: SwipeCards(
          matchEngine: _matchEngine,
          itemBuilder: (BuildContext context, int index) {
             final currentColor = getCurrentColor();
            return Card(
              elevation: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color:currentColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        decoration: BoxDecoration(
                          color:currentColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10, left: 10),
                          child: Text(
                            _swipeItems[index].content.sessionName,
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 80,
                            ),
                            for (var memberContainer
                                in sampleSessions[index].members)
                              Column(
                                children: [
                                  SizedBox(
                                      height:
                                          5), // Adjust spacing between usernames
                                  Container(
                                    child: Center(
                                      child: Text(
                                        memberContainer,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          5), // Adjust spacing between usernames
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          onStackFinished: () {},
        ),
      ),
    );
  }
}
