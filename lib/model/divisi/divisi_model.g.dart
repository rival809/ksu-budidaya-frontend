// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'divisi_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataDivisiAdapter extends TypeAdapter<DataDivisi> {
  @override
  final int typeId = 9;

  @override
  DataDivisi read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataDivisi(
      dataDivisi: (fields[0] as List?)?.cast<DataDetailDivisi>(),
    );
  }

  @override
  void write(BinaryWriter writer, DataDivisi obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.dataDivisi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataDivisiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DataDetailDivisiAdapter extends TypeAdapter<DataDetailDivisi> {
  @override
  final int typeId = 10;

  @override
  DataDetailDivisi read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataDetailDivisi(
      idDivisi: fields[0] as String?,
      nmDivisi: fields[1] as String?,
      createdAt: fields[2] as String?,
      updatedAt: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DataDetailDivisi obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.idDivisi)
      ..writeByte(1)
      ..write(obj.nmDivisi)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataDetailDivisiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
