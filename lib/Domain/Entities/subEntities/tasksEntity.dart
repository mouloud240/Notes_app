import 'package:note_app/Domain/Entities/note.dart';
import 'package:note_app/Domain/Entities/subEntities/taskEntity.dart';

import 'package:hive/hive.dart';

part 'tasksEntity.g.dart';

@HiveType(typeId: 2)
class TasksEntity extends HiveObject implements NoteContent {
  @HiveField(0)
  final List<Taskentity> tasks;

  TasksEntity({required this.tasks});

  @override
  String getType() {
    return 'TasksEntity';
  }
}