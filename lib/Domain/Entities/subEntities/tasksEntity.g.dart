// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasksEntity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TasksEntityAdapter extends TypeAdapter<TasksEntity> {
  @override
  final int typeId = 2;

  @override
  TasksEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TasksEntity(
      tasks: (fields[0] as List).cast<Taskentity>(),
    );
  }

  @override
  void write(BinaryWriter writer, TasksEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.tasks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasksEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
