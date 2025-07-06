import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text("NoteApp"),),
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






class AddNote extends StatefulWidget {
  const AddNote({super.key, required this.onNewNoteCreated});

  final Function(Note) onNewNoteCreated;

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  final titleController = TextEditingController();
  final bodyController = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AddNote"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              style: TextStyle(fontSize: 28, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
              ),
            ),
            TextFormField(
              controller: bodyController,
              style: TextStyle(fontSize: 20, color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Body",
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(titleController.text.isEmpty){
            return;
          }
          if(bodyController.text.isEmpty){
            return;
          }

          final note = Note(body: bodyController.text, title: titleController.text);

          widget.onNewNoteCreated(note);
          Navigator.of(context).pop();
        
        },
        child: Icon(Icons.save),),
    );
  }
}