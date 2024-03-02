import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:studyr/utils/gridgenerator.dart';
import 'package:studyr/screens/notes_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
  static const routeName = '/home';
}

class _HomeState extends State<Home> {
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
  bool isLoading = false;
  int _selectedIndex = 0;

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
          : FolderGrid(files: folders),
            bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotesScreen()),
      );

    } else if (index == 1) {
     
    }
  }
  
 

}

