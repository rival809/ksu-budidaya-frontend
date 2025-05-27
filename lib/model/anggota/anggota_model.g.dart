// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anggota_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnggotaResultAdapter extends TypeAdapter<AnggotaResult> {
  @override
  final int typeId = 13;

  @override
  AnggotaResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnggotaResult(
      success: fields[0] as bool?,
      data: fields[1] as DataAnggota?,
      message: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AnggotaResult obj) {
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
      other is AnggotaResultAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class DataAnggotaAdapter extends TypeAdapter<DataAnggota> {
  @override
  final int typeId = 14;

  @override
  DataAnggota read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataAnggota(
      dataAnggota: (fields[0] as List?)?.cast<DataDetailAnggota>(),
    );
  }

  @override
  void write(BinaryWriter writer, DataAnggota obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.dataAnggota);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataAnggotaAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class DataDetailAnggotaAdapter extends TypeAdapter<DataDetailAnggota> {
  @override
  final int typeId = 15;

  @override
  DataDetailAnggota read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataDetailAnggota(
      idAnggota: fields[0] as String?,
      nmAnggota: fields[1] as String?,
      alamat: fields[2] as String?,
      noWa: fields[3] as String?,
      limitPinjaman: fields[4] as String?,
      hutang: fields[5] as String?,
      createdAt: fields[6] as String?,
      updatedAt: fields[7] as String?,
      totalNominalTransaksi: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DataDetailAnggota obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.idAnggota)
      ..writeByte(1)
      ..write(obj.nmAnggota)
      ..writeByte(2)
      ..write(obj.alamat)
      ..writeByte(3)
      ..write(obj.noWa)
      ..writeByte(4)
      ..write(obj.limitPinjaman)
      ..writeByte(5)
      ..write(obj.hutang)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.updatedAt)
      ..writeByte(8)
      ..write(obj.totalNominalTransaksi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataDetailAnggotaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
