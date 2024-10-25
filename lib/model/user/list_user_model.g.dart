// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataListUserAdapter extends TypeAdapter<DataListUser> {
  @override
  final int typeId = 20;

  @override
  DataListUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataListUser(
      dataUsers: (fields[0] as List?)?.cast<DataUsers>(),
      paging: fields[1] as Paging?,
    );
  }

  @override
  void write(BinaryWriter writer, DataListUser obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.dataUsers)
      ..writeByte(1)
      ..write(obj.paging);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataListUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DataUsersAdapter extends TypeAdapter<DataUsers> {
  @override
  final int typeId = 21;

  @override
  DataUsers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataUsers(
      username: fields[0] as String?,
      name: fields[1] as String?,
      idRole: fields[2] as String?,
      createdAt: fields[3] as String?,
      updatedAt: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DataUsers obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.idRole)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataUsersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
