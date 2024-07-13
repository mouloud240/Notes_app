// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Text_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TextEntityAdapter extends TypeAdapter<TextEntity> {
  @override
  final int typeId = 1;

  @override
  TextEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TextEntity(
      content: fields[0] as String,
      isUnderlined: fields[1] as bool,
      isItalique: fields[2] as bool,
      isBold: fields[3] as bool,
      fontSize: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TextEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.content)
      ..writeByte(1)
      ..write(obj.isUnderlined)
      ..writeByte(2)
      ..write(obj.isItalique)
      ..writeByte(3)
      ..write(obj.isBold)
      ..writeByte(4)
      ..write(obj.fontSize);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
