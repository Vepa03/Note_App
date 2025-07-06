import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show StatefulWidget, State, BuildContext, Widget, EdgeInsets, TextEditingController, MediaQuery, FontWeight, Colors, TextStyle, Text, AppBar, InputBorder, InputDecoration, TextFormField, TextInputType, Column, Padding, Icons, Icon, Navigator, FloatingActionButton, Scaffold;
import 'package:note_app/models/note_model.dart' show Note;

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
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Add Note", style: TextStyle(fontSize: width*0.07, fontWeight: FontWeight.w400, color: Colors.black))),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                style: TextStyle(fontSize: 28, color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title", hintStyle: TextStyle(fontSize: width*0.07),
                ),
              ),
              TextFormField(
                controller: bodyController,
                style: TextStyle(fontSize: 20, color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Body", hintStyle: TextStyle(fontSize: width*0.05, color: Colors.grey),
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
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
        child: Icon(Icons.save), foregroundColor: Colors.black, backgroundColor: Colors.amber,),
    );
  }
}