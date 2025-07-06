import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/pages/AddNote.dart' show AddNote;
import 'package:note_app/pages/NoteView.dart';
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
      appBar: AppBar(title: Text("Notes", style: TextStyle(fontSize: width*0.07, color: Colors.black, fontWeight: FontWeight.w500),),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Noteview(note: notes[index], onNoteDeleted: onNoteDeleted, index: index,)));
              },
              child: Card(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(notes[index].title, style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold)),
                    Text(notes[index].body, style: TextStyle(fontSize: 18, color: const Color.fromARGB(255, 38, 37, 37)), 
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,)
                  ],
                ),
              ),
            );
          }),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: 
        FloatingActionButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddNote(onNewNoteCreated: onNewNoteCreated,)));
        }, child: Icon(Icons.add), foregroundColor: Colors.black, backgroundColor: Colors.amber, splashColor: Colors.black26,),
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






