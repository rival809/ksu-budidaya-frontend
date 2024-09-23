// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataSupplierAdapter extends TypeAdapter<DataSupplier> {
  @override
  final int typeId = 7;

  @override
  DataSupplier read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataSupplier(
      dataSupplier: (fields[0] as List?)?.cast<DataDetailSupplier>(),
    );
  }

  @override
  void write(BinaryWriter writer, DataSupplier obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.dataSupplier);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataSupplierAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DataDetailSupplierAdapter extends TypeAdapter<DataDetailSupplier> {
  @override
  final int typeId = 8;

  @override
  DataDetailSupplier read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataDetailSupplier(
      idSupplier: fields[0] as String?,
      nmSupplier: fields[1] as String?,
      nmPemilik: fields[2] as String?,
      nmPic: fields[3] as String?,
      noWa: fields[4] as String?,
      alamat: fields[5] as String?,
      hutangDagang: fields[6] as String?,
      createdAt: fields[7] as String?,
      updatedAt: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DataDetailSupplier obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.idSupplier)
      ..writeByte(1)
      ..write(obj.nmSupplier)
      ..writeByte(2)
      ..write(obj.nmPemilik)
      ..writeByte(3)
      ..write(obj.nmPic)
      ..writeByte(4)
      ..write(obj.noWa)
      ..writeByte(5)
      ..write(obj.alamat)
      ..writeByte(6)
      ..write(obj.hutangDagang)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataDetailSupplierAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
