// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'important_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class importantModelAdapter extends TypeAdapter<importantModel> {
  @override
  final int typeId = 1;

  @override
  importantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return importantModel(
      (fields[0] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, importantModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.newsImportantBD);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is importantModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
