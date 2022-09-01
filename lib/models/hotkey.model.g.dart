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
      fields[1] as KeyCode,
      (fields[2] as List?)?.cast<KeyModifier>(),
      fields[3] as HotKeyScope,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HotKeyModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.keyCode)
      ..writeByte(2)
      ..write(obj.modifiers)
      ..writeByte(3)
      ..write(obj.scope)
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
