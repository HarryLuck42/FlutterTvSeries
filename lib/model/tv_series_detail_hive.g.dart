// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_series_detail_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TvSeriesDetailHiveAdapter extends TypeAdapter<TvSeriesDetailHive> {
  @override
  final int typeId = 1;

  @override
  TvSeriesDetailHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TvSeriesDetailHive(
      id: fields[0] as int,
      creator: fields[1] as String,
      cast: fields[2] as String,
      genre: fields[3] as String,
      id_tv_series: fields[4] as int,
      seasons: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TvSeriesDetailHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.creator)
      ..writeByte(2)
      ..write(obj.cast)
      ..writeByte(3)
      ..write(obj.genre)
      ..writeByte(4)
      ..write(obj.id_tv_series)
      ..writeByte(5)
      ..write(obj.seasons);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TvSeriesDetailHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
