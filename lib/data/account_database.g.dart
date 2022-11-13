// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountAdapter extends TypeAdapter<Account> {
  @override
  final int typeId = 0;

  @override
  Account read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Account(
      roles: (fields[6] as List?)?.cast<String>(),
      name: fields[0] as String,
      email: fields[1] as String,
      apiKey: fields[2] as String,
      deviceToken: fields[3] as String,
      url: fields[4] as String,
      profilePicture: fields[5] as String,
      jinyaId: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.apiKey)
      ..writeByte(3)
      ..write(obj.deviceToken)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.profilePicture)
      ..writeByte(6)
      ..write(obj.roles)
      ..writeByte(7)
      ..write(obj.jinyaId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
