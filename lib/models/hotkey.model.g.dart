// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotkey.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HotKeyAdapter extends TypeAdapter<HotKeyModel> {
  @override
  final int typeId = 2;

  @override
  HotKeyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HotKeyModel(
      fields[0] as String,
      fields[1] as String,
      (fields[2] as List).cast<String>(),
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HotKeyModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.keyCode)
      ..writeByte(2)
      ..write(obj.modifiers)
      ..writeByte(4)
      ..write(obj.clipId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HotKeyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}