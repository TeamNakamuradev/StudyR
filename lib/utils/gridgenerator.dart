// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:studyr/utils/hex.dart';

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
          : Container(
              color: Colors.transparent, // change this to your preferred color
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // number of items per row
                ),
                itemCount: widget.files.length,
                itemBuilder: (context, index) {
                  final file = widget.files[index];
                  return Card(
                    elevation: 0,
                    child: GridTile(
                      footer: Center(
                        child: Text(
                          file['name'],
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          if (file['type'] == 'folder') {
                            // add navigation to folder
                          } else {
                            // add navigation to file
                          }
                        },
                        child: Align(
                          alignment: Alignment(0, -0.4),
                          child: Container(
                            child: file['iconUrl'] != null
                                ? Image.network(file['iconUrl']!)
                                : Icon(
                                    Icons.folder_rounded,
                                    size: 150,
                                    color: HexColor("#438DE6"),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
