// import 'package:flutter/material.dart';
// import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
// import 'package:studyr/screens/community.dart';

// class SwipePage extends StatelessWidget {
//    final Community community;

//   SwipePage({required this.community});
//   final List<String> images = [
    
//     'assets/image1.png',
//     'assets/image2.png',
//     'assets/image3.png',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//   title: Text('${community.name}'),
// ),
//       body: Swiper(
//         itemBuilder: (BuildContext context, int index) {
//           return new Image.asset(images[index], fit: BoxFit.fill);
//         },
//         itemCount: images.length,
//         itemWidth: 300.0,
//         layout: SwiperLayout.TINDER,
//         onTap: (index) {
        
//           Navigator.pushNamed(context, '/chat_video');
//         },
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:studyr/screens/community.dart';

class SwipePage extends StatelessWidget {
   final Community community;

  SwipePage({required this.community, required String title});
  final List<String> images = [
    
    'assets/image1.png',
    'assets/image2.png',
    'assets/image3.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${community.name}'),
      ),
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.asset(images[index], fit: BoxFit.fill);
        },
        itemCount: 2,
        itemWidth: 300.0,
        layout: SwiperLayout.TINDER,
        
      ),
    );
  }
}
