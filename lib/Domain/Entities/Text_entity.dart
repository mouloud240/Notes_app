import 'package:hive/hive.dart';
import 'package:note_app/Domain/Entities/note.dart';

part 'Text_entity.g.dart';

@HiveType(typeId: 1)
class TextEntity extends HiveObject implements NoteContent {
  @HiveField(0)
  final String content;

  @HiveField(1)
  final bool isUnderlined;

  @HiveField(2)
  final bool isItalique;

  @HiveField(3)
  final bool isBold;

  @HiveField(4)
  final int fontSize;

  TextEntity({
    required this.content,
    required this.isUnderlined,
    required this.isItalique,
    required this.isBold,
    required this.fontSize,
  });

  @override
  String getType() {
    return 'TextEntity';
  }
}