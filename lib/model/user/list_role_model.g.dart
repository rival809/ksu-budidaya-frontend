// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_role_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataListRoleAdapter extends TypeAdapter<DataListRole> {
  @override
  final int typeId = 4;

  @override
  DataListRole read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataListRole(
      dataRoles: (fields[0] as List?)?.cast<DataRoles>(),
      paging: fields[1] as PagingRole?,
    );
  }

  @override
  void write(BinaryWriter writer, DataListRole obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.dataRoles)
      ..writeByte(1)
      ..write(obj.paging);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataListRoleAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class DataRolesAdapter extends TypeAdapter<DataRoles> {
  @override
  final int typeId = 5;

  @override
  DataRoles read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataRoles(
      idRole: fields[0] as String?,
      roleName: fields[1] as String?,
      stsAnggota: fields[2] as bool?,
      stsPembayaranPinjaman: fields[3] as bool?,
      stsKartuPiutang: fields[4] as bool?,
      stsSupplier: fields[5] as bool?,
      stsDivisi: fields[6] as bool?,
      stsProduk: fields[7] as bool?,
      stsPembelian: fields[8] as bool?,
      stsPenjualan: fields[9] as bool?,
      stsRetur: fields[10] as bool?,
      stsPembayaranHutang: fields[11] as bool?,
      stsEstimasi: fields[12] as bool?,
      stsStocktakeHarian: fields[13] as bool?,
      stsStockOpname: fields[14] as bool?,
      stsCashInCashOut: fields[15] as bool?,
      stsCashMovement: fields[16] as bool?,
      stsUser: fields[17] as bool?,
      stsRole: fields[18] as bool?,
      stsCetakLabel: fields[19] as bool?,
      stsCetakBarcode: fields[20] as bool?,
      stsAwalAkhirHari: fields[21] as bool?,
      stsDashboard: fields[22] as bool?,
      stsLaporan: fields[23] as bool?,
      createdAt: fields[24] as String?,
      updatedAt: fields[25] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DataRoles obj) {
    writer
      ..writeByte(26)
      ..writeByte(0)
      ..write(obj.idRole)
      ..writeByte(1)
      ..write(obj.roleName)
      ..writeByte(2)
      ..write(obj.stsAnggota)
      ..writeByte(3)
      ..write(obj.stsPembayaranPinjaman)
      ..writeByte(4)
      ..write(obj.stsKartuPiutang)
      ..writeByte(5)
      ..write(obj.stsSupplier)
      ..writeByte(6)
      ..write(obj.stsDivisi)
      ..writeByte(7)
      ..write(obj.stsProduk)
      ..writeByte(8)
      ..write(obj.stsPembelian)
      ..writeByte(9)
      ..write(obj.stsPenjualan)
      ..writeByte(10)
      ..write(obj.stsRetur)
      ..writeByte(11)
      ..write(obj.stsPembayaranHutang)
      ..writeByte(12)
      ..write(obj.stsEstimasi)
      ..writeByte(13)
      ..write(obj.stsStocktakeHarian)
      ..writeByte(14)
      ..write(obj.stsStockOpname)
      ..writeByte(15)
      ..write(obj.stsCashInCashOut)
      ..writeByte(16)
      ..write(obj.stsCashMovement)
      ..writeByte(17)
      ..write(obj.stsUser)
      ..writeByte(18)
      ..write(obj.stsRole)
      ..writeByte(19)
      ..write(obj.stsCetakLabel)
      ..writeByte(20)
      ..write(obj.stsCetakBarcode)
      ..writeByte(21)
      ..write(obj.stsAwalAkhirHari)
      ..writeByte(22)
      ..write(obj.stsDashboard)
      ..writeByte(23)
      ..write(obj.stsLaporan)
      ..writeByte(24)
      ..write(obj.createdAt)
      ..writeByte(25)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataRolesAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class PagingRoleAdapter extends TypeAdapter<PagingRole> {
  @override
  final int typeId = 6;

  @override
  PagingRole read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PagingRole(
      page: fields[0] as int?,
      totalItem: fields[1] as int?,
      totalPage: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PagingRole obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.page)
      ..writeByte(1)
      ..write(obj.totalItem)
      ..writeByte(2)
      ..write(obj.totalPage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PagingRoleAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
