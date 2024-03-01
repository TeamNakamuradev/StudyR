import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List folders = [
    {
      'name': 'Folder 1',
      'iconUrl':
          'https://cdn.pixabay.com/photo/2017/08/30/01/05/milky-way-2695569_960_720.jpg',
    },
    {
      'name': 'Folder 2',
      'iconUrl':
          'https://cdn.pixabay.com/photo/2017/08/30/01/05/milky-way-2695569_960_720.jpg',
    },
    {
      'name': 'Folder 3',
      'iconUrl':
          'https://cdn.pixabay.com/photo/2017/08/30/01/05/milky-way-2695569_960_720.jpg',
    },
  ];
  // bool isLoading = true;
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
          : ListView.builder(
              itemCount: folders.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(folders[index]['iconUrl']),
                    ),
                    title: Text(
                      folders[index]['name'],
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    tileColor: index % 2 == 0 ? Colors.white : Colors.grey[200],
                  ),
                );
              },
            ),
    );
  }
}
