// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:swipe_cards/swipe_cards.dart';

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
  late List<List<Container>> listOfMembers;

  @override
  void initState() {
    super.initState();
    listOfMembers = [];
    List<Color> _colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange
    ];
    for (int i = 0; i < widget.sessions.length; i++) {
      _swipeItems.add(SwipeItem(
          content: widget.sessions[0],
          likeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Liked "),
              duration: Duration(milliseconds: 500),
            ));
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
          }));


          var members = widget.sessions[i].members.map((item) {
            return Container(
              child: Column(
                children: [
                  Container(
                    child: Center(child: Text(item, style: TextStyle(fontSize: 20),),),
                  ),
                  Divider(color: Colors.grey,endIndent: 5,)
                ],
              ),
            );
          } ).toList();

          listOfMembers.add(members);


    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
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
              return Card(
                elevation: 2,
                child: Container(
                  // width: ,

                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[200],
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
                            color: Colors.blue[200],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10, left: 10),
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
                          child: ListView(
                            
                            children: listOfMembers[index],
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            onStackFinished: () {},
          ),
        ));
  }
}
