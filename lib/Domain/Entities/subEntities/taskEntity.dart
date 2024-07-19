import 'package:hive_flutter/adapters.dart';
part 'taskEntity.g.dart';

@HiveType(typeId: 3)
class Taskentity extends HiveObject {
  @HiveField(0)
  bool isDone;
  @HiveField(1)
  String task;
  Taskentity({required this.isDone, required this.task});
}
