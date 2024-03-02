import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final String userName;

  DashboardPage({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            child: Center(
              child: Text(
                'Welcome, $userName',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://source.unsplash.com/random'), // replace with your image
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
