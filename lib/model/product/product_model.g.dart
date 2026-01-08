// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductResultAdapter extends TypeAdapter<ProductResult> {
  @override
  final int typeId = 16;

  @override
  ProductResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductResult(
      success: fields[0] as bool?,
      data: fields[1] as DataProduct?,
      message: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductResult obj) {
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
      other is ProductResultAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class DataProductAdapter extends TypeAdapter<DataProduct> {
  @override
  final int typeId = 17;

  @override
  DataProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataProduct(
      dataProduct: (fields[0] as List?)?.cast<DataDetailProduct>(),
      paging: fields[1] as PagingRole?,
      totalKeseluruhan: fields[2] as TotalKeseluruhan?,
    );
  }

  @override
  void write(BinaryWriter writer, DataProduct obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.dataProduct)
      ..writeByte(1)
      ..write(obj.paging)
      ..writeByte(2)
      ..write(obj.totalKeseluruhan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataProductAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

class DataDetailProductAdapter extends TypeAdapter<DataDetailProduct> {
  @override
  final int typeId = 18;

  @override
  DataDetailProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataDetailProduct(
      idProduct: fields[0] as String?,
      nmProduct: fields[1] as String?,
      idDivisi: fields[2] as String?,
      idSupplier: fields[3] as String?,
      hargaJual: fields[4] as String?,
      hargaBeli: fields[5] as String?,
      statusProduct: fields[6] as bool?,
      jumlah: fields[7] as int?,
      keterangan: fields[8] as String?,
      createdAt: fields[9] as String?,
      updatedAt: fields[10] as String?,
      totalJual: fields[11] as double?,
      totalBeli: fields[12] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, DataDetailProduct obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.idProduct)
      ..writeByte(1)
      ..write(obj.nmProduct)
      ..writeByte(2)
      ..write(obj.idDivisi)
      ..writeByte(3)
      ..write(obj.idSupplier)
      ..writeByte(4)
      ..write(obj.hargaJual)
      ..writeByte(5)
      ..write(obj.hargaBeli)
      ..writeByte(6)
      ..write(obj.statusProduct)
      ..writeByte(7)
      ..write(obj.jumlah)
      ..writeByte(8)
      ..write(obj.keterangan)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.updatedAt)
      ..writeByte(11)
      ..write(obj.totalJual)
      ..writeByte(12)
      ..write(obj.totalBeli);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataDetailProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TotalKeseluruhanAdapter extends TypeAdapter<TotalKeseluruhan> {
  @override
  final int typeId = 19;

  @override
  TotalKeseluruhan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TotalKeseluruhan(
      totalJumlah: fields[0] as double?,
      totalJual: fields[1] as double?,
      totalBeli: fields[2] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, TotalKeseluruhan obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.totalJumlah)
      ..writeByte(1)
      ..write(obj.totalJual)
      ..writeByte(2)
      ..write(obj.totalBeli);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TotalKeseluruhanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
