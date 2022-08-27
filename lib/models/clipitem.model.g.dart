// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clipitem.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClipItemAdapter extends TypeAdapter<ClipItem> {
  @override
  final int typeId = 0;

  @override
  ClipItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClipItem(
      fields[1] as String,
      fields[2] as String,
      fields[3] == null ? false : fields[3] as bool,
      fields[4] == null ? [] : (fields[4] as List).cast<String>(),
      fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ClipItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.copiedText)
      ..writeByte(2)
      ..write(obj.datetime)
      ..writeByte(3)
      ..write(obj.favorite)
      ..writeByte(4)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClipItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
