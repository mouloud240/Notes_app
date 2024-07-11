import 'package:hive/hive.dart';
import 'package:note_app/Domain/Entities/Note.dart';
part 'NoteModel.g.dart'; // Necessary for Hive type adapter generation

@HiveType(typeId: 0)
class NoteModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final DateTime creationDate;

  @HiveField(4)
  final DateTime? updatedAt;
  @HiveField(5)
  final bool isArchived;

  NoteModel(
      {required this.id,
      required this.title,
      required this.content,
      required this.creationDate,
      this.updatedAt,
      required this.isArchived});

  factory NoteModel.fromEntity(Note note) {
    return NoteModel(
        id: note.id,
        creationDate: note.creationDate,
        isArchived: note.isArchived,
        title: note.title,
        content: note.title,
        updatedAt: note.updatedAt);
  }
  Note toEntity() {
    return Note(
        id: id,
        creationDate: creationDate,
        isArchived: isArchived,
        updatedAt: updatedAt,
        title: title,
        content: content);
  }
}
