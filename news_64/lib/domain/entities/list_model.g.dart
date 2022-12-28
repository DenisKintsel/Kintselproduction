// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class listModelAdapter extends TypeAdapter<listModel> {
  @override
  final int typeId = 0;

  @override
  listModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return listModel(
      (fields[0] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, listModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.newsBD);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is listModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
