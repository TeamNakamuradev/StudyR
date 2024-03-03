import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<String> notes = [];
  Color themeColor = Color.fromARGB(255, 237, 237, 240);

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      notes = prefs.getStringList('notes') ?? [];
    });
  }

  _saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notes', notes);
  }

  _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
      _saveNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        backgroundColor: themeColor,
        actions: [
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () =>
                setState(() => themeColor = Color.fromARGB(255, 245, 240, 245)),
          ),
          
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          crossAxisSpacing: 8.0, 
          mainAxisSpacing: 8.0, 
          childAspectRatio: 0.5,
        ),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 1.0, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  8.0), 
              side: BorderSide(
                  color: Colors.black.withOpacity(0.1),
                  width: 0.5), 
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notes[index],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteNote(index),
                  ),
                ),
              ],
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final note = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNoteScreen()),
          );

          if (note != null && note.isNotEmpty) {
            setState(() {
              notes.add(note);
              _saveNotes();
            });
          }
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController noteController = TextEditingController();
  bool isSyncing = false;
  String syncStatus = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Add Note'),
            SizedBox(width: 8),
            if (isSyncing)
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 0.5,
                ),
              ),
            if (syncStatus.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  syncStatus,
                  style: TextStyle(fontSize: 12),
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                isSyncing = true;
              });

              await _syncWithSharedPreferences();

              setState(() {
                isSyncing = false;
                syncStatus = 'Saved';
              });

              _hideSyncStatusAfterDelay();

              Navigator.pop(context, noteController.text);
            },
            icon: Icon(Icons.done),
          ),
        ],
      ), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: noteController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                autofocus: true,
                decoration: InputDecoration.collapsed(hintText: ''),
                onChanged: (value) {
                  _startContinuousSync();
                },
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _syncWithSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      await Future.delayed(Duration(seconds: 2));

      List<String> existingNotes = prefs.getStringList('notes') ?? [];
      existingNotes.add(noteController.text);
      prefs.setStringList('notes', existingNotes);
    } catch (e) {
      print('Syncing error: $e');
    }
  }

  void _startContinuousSync() {
    Timer.periodic(Duration(seconds:3), (timer) async {
      if (noteController.text.isEmpty) return;

      if (isSyncing) return;

      setState(() {
        isSyncing = true;
        syncStatus = 'Syncing...';
      });

      await _syncWithSharedPreferences();

      setState(() {
        isSyncing = false;
        syncStatus = 'Synced';
      });

      _hideSyncStatusAfterDelay();
    });
  }

  void _hideSyncStatusAfterDelay() {
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        syncStatus = '';
      });
    });
  }
}



