// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ref_cash_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RefCashResultAdapter extends TypeAdapter<RefCashResult> {
  @override
  final int typeId = 11;

  @override
  RefCashResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RefCashResult(
      success: fields[0] as bool?,
      data: (fields[1] as List?)?.cast<DataRefCash>(),
      message: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RefCashResult obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.success)
      ..writeByte(1)
      ..write(obj.data)
      ..writeByte(2)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RefCashResultAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DataRefCashAdapter extends TypeAdapter<DataRefCash> {
  @override
  final int typeId = 12;

  @override
  DataRefCash read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataRefCash(
      idCash: fields[0] as String?,
      nmCash: fields[1] as String?,
      createdAt: fields[2] as String?,
      updatedAt: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DataRefCash obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.idCash)
      ..writeByte(1)
      ..write(obj.nmCash)
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
      other is DataRefCashAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
