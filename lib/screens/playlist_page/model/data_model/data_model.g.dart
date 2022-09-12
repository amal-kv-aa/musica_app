// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistmodelAdapter extends TypeAdapter<Playlistmodel> {
  @override
  final int typeId = 1;

  @override
  Playlistmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Playlistmodel(
      name: fields[0] as String?,
      dbsonglist: (fields[1] as List).cast<dynamic>(),
      image: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Playlistmodel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.dbsonglist)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
