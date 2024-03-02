

// import 'package:flutter/material.dart';
// import 'package:studyr/screens/login.dart';

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           _buildCurvedBackground(context),
//           _buildContent(context),
//         ],
//       ),
//     );
//   }

//   Widget _buildCurvedBackground(BuildContext context) {
//     return ClipPath(
//       clipper: CurveClipper(),
//       child: Container(
//         color: Colors.black87,
//         height: MediaQuery.of(context).size.height * 0.5,
//       ),
//     );
//   }

//   Widget _buildContent(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         SizedBox(height: 10), 
//         Text(
//           'Welcome to StudyR\nBuild meaningful connections, share interests, and have fun!',
//           style: TextStyle(
//             fontSize: 24.0,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(height: 300), 
//         ElevatedButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => LoginPage()),
//             );
//           },
//           child: Text('Get Started'),
//         ),
//       ],
//     );
//   }
// }

// class CurveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, size.height * 0.85);
//     path.quadraticBezierTo(
//         size.width * 0.2, size.height, size.width * 0.5, size.height * 0.85);
//     path.quadraticBezierTo(
//         size.width * 0.8, size.height * 0.7, size.width, size.height * 0.85);
//     path.lineTo(size.width, 0);
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

import 'package:flutter/material.dart';
import 'package:studyr/screens/login.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildCurvedBackground(context),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildCurvedBackground(BuildContext context) {
    return ClipPath(
      clipper: CurveClipper(),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        height: MediaQuery.of(context).size.height * 0.6, // Adjusted the height to make it lower
        color: Colors.black87,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Text(
          'Welcome to StudyR\nBuild meaningful connections, share interests, and have fun!',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 200),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: Text('Get Started'),
        ),
      ],
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.85);
    path.quadraticBezierTo(
        size.width * 0.2, size.height, size.width * 0.5, size.height * 0.85);
    path.quadraticBezierTo(
        size.width * 0.8, size.height * 0.7, size.width, size.height * 0.85);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
