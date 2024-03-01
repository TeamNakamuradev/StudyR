import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:studyr/utils/gridgenerator.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
  static const routeName = '/home';
}

class _DashboardState extends State<Dashboard> {
  List folders = [
    {
      'name': 'Folder 1',

    },
    {
      'name': 'Folder 2',

    },
    {
      'name': 'Folder 3',

    },
    {
      'name': 'Folder 4',

    },
    {
      'name': 'Folder 5',

    }
  ];
  bool isLoading = false; //make this true after adding an API

  @override
  void initState() {
    super.initState();
    // this.fetchFolders(); // uncomment this line to fetch folders from an API
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
            : FolderDisplay(files: folders),
    );
  }
}
