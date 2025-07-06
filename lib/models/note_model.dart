class Note{
  final String title;
  final String body;

  Note({required this.body, required this.title});

  Map<String, dynamic> toJson(){
    return{
      'title': title,
      'body': body,
    };
  }

  factory Note.fromJson(Map<String, dynamic> json){
    return Note(
      body: json['body'], 
      title: json['title']);
  }


}