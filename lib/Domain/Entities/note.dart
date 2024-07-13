import 'package:note_app/Domain/Entities/Text_entity.dart';

class Note {
  int id;
  String title;
  TextEntity content;
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
