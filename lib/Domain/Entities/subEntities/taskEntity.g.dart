// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taskEntity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskentityAdapter extends TypeAdapter<Taskentity> {
  @override
  final int typeId = 3;

  @override
  Taskentity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Taskentity(
      isDone: fields[0] as bool,
      task: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Taskentity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.isDone)
      ..writeByte(1)
      ..write(obj.task);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskentityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
