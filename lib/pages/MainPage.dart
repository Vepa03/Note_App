import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/pages/AddNote.dart' show AddNote;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  @override
  void initState(){
    super.initState();
    loadNotes();

  }

  
  
  
  List<Note> notes = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Note", style: TextStyle(fontSize: width*0.07, color: Colors.black, fontWeight: FontWeight.w400),),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index){
            return Card(
              child: Column(
                children: [
                  Text(notes[index].title, style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold)),
                  Text(notes[index].body, style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 38, 37, 37)), 
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,)
                ],
              ),
            );
          }),
      ),
      floatingActionButton: 
        FloatingActionButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddNote(onNewNoteCreated: onNewNoteCreated,)));
        }, child: Icon(Icons.add),),
    );
  }

  void onNewNoteCreated(Note note){
    notes.add(note);
    saveNotes();
    setState(() {

    });
  }

  void onNoteDeleted(int index){
    notes.removeAt(index);
    saveNotes();  
    setState(() {
    });
  }

  void loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? notesString = prefs.getString('notes');

    if (notesString != null) {
      final List<dynamic> jsonList = jsonDecode(notesString);
      setState(() {
        notes = jsonList.map((json) => Note.fromJson(json)).toList();
      });
    }
  }
  void saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = jsonEncode(notes.map((note) => note.toJson()).toList());
    await prefs.setString('notes', jsonString);
  }


}






