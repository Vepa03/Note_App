import 'package:flutter/material.dart';

class Mainpage extends StatelessWidget {
  const Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NoteApp"),),
      body: Center(
        child: Text("Text"),
      ),
      floatingActionButton: 
        FloatingActionButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddNote()));
        }, child: Icon(Icons.add),),
    );
  }
}



class AddNote extends StatelessWidget {
  const AddNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AddNote"),),
      body: Column(
        children: [
          TextFormField(
            style: TextStyle(fontSize: 28, color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "dwed",
            ),
          )
        ],
      )
    );
  }
}