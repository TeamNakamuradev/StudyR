// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:swipe_cards/swipe_cards.dart';

class StudySession {
  StudySession({
    required this.sessionID,
    required this.members,
    required this.tags,
  });
  final String sessionID;
  final List<String> tags;
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

  @override
  void initState() {
    super.initState();

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
          child: SwipeCards(
            matchEngine: _matchEngine,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                // width: ,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [Text(_swipeItems[0].content.sessionID)],
                ),
              );
            },
            onStackFinished: () {},
          ),
        ));
  }
}
