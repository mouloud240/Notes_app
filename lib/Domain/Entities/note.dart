import 'package:note_app/Domain/Entities/Text_entity.dart';

abstract class NoteContent {
  String getType();
}

class Note {
  int id;
  String title;
  NoteContent content;
  DateTime creationDate;
  DateTime? updatedAt;
  bool isArchived;
  Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.creationDate,
      this.updatedAt,
      required this.isArchived});
}
