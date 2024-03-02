import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

class StudySession{
  StudySession({required this.eventID });
  final String eventID;
  final List<String> tags ;
  final List<String> Members ;
}


class Swiper extends StatefulWidget {
  const Swiper({super.key});

  @override
  State<Swiper> createState() => _SwiperState();
}

class _SwiperState extends State<Swiper> {
  @override
  Widget build(BuildContext context) {
    return ;
  }
}