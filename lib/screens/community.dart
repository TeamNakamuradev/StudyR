import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  final List<String> imageUrls;

  CommunityPage({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community Page'),
      ),
      body: ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.0, // to make image square
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: Text('Join'),
                    onPressed: () {
                      // Add your action here
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
