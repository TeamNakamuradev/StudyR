import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
  static const routeName = '/home';
}

class _DashboardState extends State<Dashboard> {
  List folders = [
    {
      'name': 'Folder 1',
      'iconUrl': 'https://your-api-url.com/folder1.png',
    },
    {
      'name': 'Folder 2',
      'iconUrl': 'https://your-api-url.com/folder2.png',
    },
    {
      'name': 'Folder 3',
      'iconUrl': 'https://your-api-url.com/folder3.png',
    },
    {
      'name': 'Folder 4',
      'iconUrl': 'https://your-api-url.com/folder4.png',
    },
    {
      'name': 'Folder 5',
      'iconUrl': 'https://your-api-url.com/folder5.png',
    }
  ];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // this.fetchFolders();
  }

  // fetchFolders() async {
  //   var url = 'https://your-api-url.com/folders';
  //   var response = await http.get(url as Uri);
  //   if (response.statusCode == 200) {
  //     var items = json.decode(response.body);
  //     setState(() {
  //       folders = items;
  //       isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Folder Display'),
        backgroundColor: Colors.blueGrey,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // number of items per row
              ),
              itemCount: folders.length,
              itemBuilder: (context, index) {
                return Card(
                  child: GridTile(
                    child: Icon(Icons.folder, size: 100),
                    footer: Center(
                      child: Text(
                        folders[index]['name'],
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
