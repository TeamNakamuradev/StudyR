// import 'package:flutter/material.dart';

// class LeaderboardPage extends StatefulWidget {
//   final List<LeaderboardEntry> entries;

//   const LeaderboardPage({Key? key, required this.entries}) : super(key: key);

//   @override
//   _LeaderboardPageState createState() => _LeaderboardPageState();
// }

// class _LeaderboardPageState extends State<LeaderboardPage> {
//   List<LeaderboardEntry> sortedEntries = [];

//   @override
//   void initState() {
//     super.initState();
//     sortedEntries = widget.entries;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leaderboard'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.sort),
//             onPressed: () {
//               setState(() {
//                 sortedEntries.sort((a, b) => b.points.compareTo(a.points));
//               });
//             },
//           ),
//         ],
//       ),
//       body: DataTable(
//         columns: const [
//           DataColumn(label: Text('Rank')),
//           DataColumn(label: Text('Name')),
//           DataColumn(label: Text('Challenge')),
//           DataColumn(label: Text('Points')),
//         ],
//         rows: sortedEntries.map((entry) => _buildLeaderboardRow(entry)).toList(),
//       ),
//     );
//   }

//   DataRow _buildLeaderboardRow(LeaderboardEntry entry) {
//     return DataRow(
//       cells: [
//         DataCell(Text(entry.rank.toString())),
//         DataCell(Text(entry.name)),
//         DataCell(Text(entry.challenge.toString())),
//         DataCell(Text(entry.points.toString())),
//       ],
//     );
//   }
// }

// class LeaderboardEntry {
//   final int rank;
//   final String name;
//   final int challenge;
//   final int points;

//   const LeaderboardEntry({
//     required this.rank,
//     required this.name,
//     required this.challenge,
//     required this.points,
//   });
// }







// import 'package:flutter/material.dart';

// class LeaderboardPage extends StatefulWidget {
//   final List<LeaderboardEntry> entries;

//   const LeaderboardPage({Key? key, required this.entries}) : super(key: key);

//   @override
//   _LeaderboardPageState createState() => _LeaderboardPageState();
// }

// class _LeaderboardPageState extends State<LeaderboardPage> {
//   List<LeaderboardEntry> sortedEntries = [];

//   @override
//   void initState() {
//     super.initState();
//     sortedEntries = widget.entries;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Leaderboard'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.sort),
//             onPressed: () {
//               setState(() {
//                 sortedEntries.sort((a, b) => b.points.compareTo(a.points));
//               });
//             },
//           ),
//         ],
//       ),
//       body: DataTable(
//         columns: const [
//           DataColumn(label: Text('Rank')),
//           DataColumn(label: Text('Name')),
//           DataColumn(label: Text('Challenge')),
//           DataColumn(label: Text('Points')),
//         ],
//         rows: sortedEntries.map((entry) => _buildLeaderboardRow(entry)).toList(),
//       ),
//     );
//   }

//   DataRow _buildLeaderboardRow(LeaderboardEntry entry) {
//     return DataRow(
//       cells: [
//         DataCell(Text(entry.rank.toString())),
//         DataCell(Row(
//           children: [
//             Icon(Icons.person),
//             SizedBox(width: 8.0),
//             Text(entry.name),
//           ],
//         )),
//         DataCell(Text(entry.challenge.toString())),
//         DataCell(Row(
//           children: [
//             Icon(Icons.star),
//             SizedBox(width: 8.0),
//             Text(entry.points.toString()),
//           ],
//         )),
//       ],
//     );
//   }
// }

// class LeaderboardEntry {
//   final int rank;
//   final String name;
//   final int challenge;
//   final int points;

//   const LeaderboardEntry({
//     required this.rank,
//     required this.name,
//     required this.challenge,
//     required this.points,
//   });
// }









import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  final List<User> users;

  LeaderboardPage({required this.users});

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<User> sortedUsers = [];

  @override
  void initState() {
    super.initState();
    sortedUsers = widget.users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildUserAvatar('assets/image1.png', 'User 5',2),
                    _buildUserAvatar('assets/image2.png', 'User 3',1),
                    _buildUserAvatar('assets/image3.png', 'User 4',3),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
  child: ListView.builder(
    itemCount: sortedUsers.length,
    itemBuilder: (context, index) {
      User user =sortedUsers[index];
      bool isUser5 =user.name == 'User5';
      
      return Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isUser5 ? Color.fromARGB(255, 94, 166, 224) : Color.fromARGB(255, 159, 175, 233), 
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          leading: Text('${index + 1}'),
          title: Text(user.name),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.monetization_on, color: Colors.yellow),
              SizedBox(width: 4.0),
              Text('${user.score}'),
            ],
          ),
        ),
      );
    },
  ),
),
          ],
        ),
      ),
    );
  }

  Column _buildUserAvatar(String imagePath, String label,int rank) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imagePath),
          radius: 30.0,
        ),
        SizedBox(height: 8.0),
        Text(
           '$label\nRank: $rank',
        textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class User {
  final String name;
  final int score;

  User({required this.name, required this.score});
}