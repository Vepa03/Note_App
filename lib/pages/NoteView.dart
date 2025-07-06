import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/pages/MainPage.dart';

// ignore: must_be_immutable
class Noteview extends StatelessWidget {
  const Noteview({super.key, required this.note, required this.onNoteDeleted, required this.index});
  final Note note;
  final int index;
  final Function (int) onNoteDeleted;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text(note.title, style: TextStyle(fontSize: width*0.06, fontWeight: FontWeight.w400),),
      actions: [
        GestureDetector(
          onTap: (){
            showDialog(context: context, 
            builder: (context)=> AlertDialog(
              backgroundColor: Colors.white,
              title: Text("Delete this ?", style: TextStyle(fontSize: width*0.07),),
              content: Text("Note ${note.title} will be deleted !", style: TextStyle(fontSize: width*0.04),),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Mainpage()));
                    onNoteDeleted(index);
                  }, child: Text("Yes", style: TextStyle(fontSize: width*0.04, fontWeight: FontWeight.w500, color: Colors.black),),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),),
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("No", style: TextStyle(fontSize: width*0.04, fontWeight: FontWeight.w500, color: Colors.black)), 
                    style: ElevatedButton.styleFrom( backgroundColor: Colors.white),)
                  ],
                )
                
              ],
            ),);
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.delete, color: Colors.black,),
          ),
        )
      ],),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.body,
                  style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}