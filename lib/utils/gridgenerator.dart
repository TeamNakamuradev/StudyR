import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FolderDisplay extends StatefulWidget {
  final List<dynamic> files;

  const FolderDisplay({Key? key, required this.files}) : super(key: key);

  @override
  _FolderDisplayState createState() => _FolderDisplayState();
}

class _FolderDisplayState extends State<FolderDisplay> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              // Remove the gridDelegate from build
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // number of items per row
              ),
              itemCount: widget.files.length,
              itemBuilder: (context, index) {
                final file = widget.files[index];
                return Card(
                  child: GridTile(
                    child: file['iconUrl'] != null
                        ? Image.network(file['iconUrl']!)
                        : Icon(Icons.folder, size: 100),
                    footer: Center(
                      child: Text(
                        file['name'],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
