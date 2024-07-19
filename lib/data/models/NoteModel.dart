import 'package:hive/hive.dart';
import 'package:note_app/Domain/Entities/Text_entity.dart';
import 'package:note_app/Domain/Entities/note.dart';
part 'NoteModel.g.dart'; // Necessary for Hive type adapter generation

@HiveType(typeId: 0)
class NoteModel extends Note {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final NoteContent content;

  @HiveField(3)
  final DateTime creationDate;

  @HiveField(4)
  final DateTime? updatedAt;
  @HiveField(5)
  final bool isArchived;

  NoteModel(
      {required int id,
      required String title,
      required NoteContent content,
      required DateTime creationDate,
      DateTime? updatedAt,
      required bool isArchived})
      : id = id,
        title = title,
        content = content,
        creationDate = creationDate,
        updatedAt = updatedAt,
        isArchived = isArchived,
        super(
            id: id,
            title: title,
            content: content,
            creationDate: creationDate,
            updatedAt: updatedAt,
            isArchived: isArchived);

  Note toEntity() {
    return Note(
        id: id,
        title: title,
        content: content,
        creationDate: creationDate,
        isArchived: isArchived);
  }
}
