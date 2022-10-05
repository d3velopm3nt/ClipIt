// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsAdapter extends TypeAdapter<SettingsModel> {
  @override
  final int typeId = 3;

  @override
  SettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsModel(
      fields[4] as bool,
      fields[5] as bool,
      fields[6] as bool,
      fields[0] as bool,
      fields[2] as int,
      fields[3] as int,
      fields[7] as bool,
      fields[8] == null ? false : fields[8] as bool,
      fields[9] == null ? false : fields[9] as bool,
    )..windowMode = fields[1] as bool;
  }

  @override
  void write(BinaryWriter writer, SettingsModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.darkMode)
      ..writeByte(1)
      ..write(obj.windowMode)
      ..writeByte(2)
      ..write(obj.primaryColor)
      ..writeByte(3)
      ..write(obj.secondaryColor)
      ..writeByte(4)
      ..write(obj.alwaysOnTop)
      ..writeByte(5)
      ..write(obj.dockToSide)
      ..writeByte(6)
      ..write(obj.launchAtStartup)
      ..writeByte(7)
      ..write(obj.hideClipboardAfterCopy)
      ..writeByte(8)
      ..write(obj.showQuickSelect)
      ..writeByte(9)
      ..write(obj.setupDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
