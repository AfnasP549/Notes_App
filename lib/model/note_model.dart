class NoteModel {
  String id;
  String title;
  String content;
  DateTime lastModified;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.lastModified,
  });

  Map<String, dynamic> toJson()=> {
      'id': id,
      'title': title,
      'content': content,
      'lastModified': lastModified.toIso8601String(),
  };

  factory NoteModel.fromjson(Map<String , dynamic> json) => NoteModel(
    id: json['id'], 
    title: json['title'], 
    content: json['content'], 
    lastModified: DateTime.parse(json['lastModified']));
}
