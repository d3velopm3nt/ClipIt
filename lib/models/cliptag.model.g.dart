// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliptag.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClipTagAdapter extends TypeAdapter<ClipTag> {
  @override
  final int typeId = 1;

  @override
  ClipTag read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClipTag(
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ClipTag obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.datetime)
      ..writeByte(3)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClipTagAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
