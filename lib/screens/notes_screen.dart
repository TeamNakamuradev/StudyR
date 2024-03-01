import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<String> notes = [];
  Color themeColor = Colors.blue;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        backgroundColor: themeColor,
        actions: [
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () => setState(() => themeColor = Colors.red),
          ),
          IconButton(
            icon: Icon(Icons.color_lens_outlined),
            onPressed: () => setState(() => themeColor = Colors.green),
          ),
        
        ],
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(notes[index]),
            onDismissed: (direction) {
              setState(() {
                notes.removeAt(index);
              });
            },
            background: Container(color: Colors.red),
            child: ListTile(title: Text(notes[index])),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final note = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              TextEditingController noteController = TextEditingController(); 
              return AlertDialog(
                title: const Text('Add a note'),
                content: TextField(
                  controller: noteController,
                  autofocus: true,
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text('Add'),
                    onPressed: () {
                      Navigator.pop(context, noteController.text);
                    },
                  ),
                ],
              );
            },
          );
          if (note != null && note.isNotEmpty ) {
            setState(() {
              notes.add(note);
            });
          }
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }
}