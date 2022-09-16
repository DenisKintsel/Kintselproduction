// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_bool_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class listBoolModelAdapter extends TypeAdapter<listBoolModel> {
  @override
  final int typeId = 0;

  @override
  listBoolModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return listBoolModel(
      (fields[0] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, listBoolModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.listBool);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is listBoolModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
