// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsSourceAdapter extends TypeAdapter<NewsSource> {
  @override
  final int typeId = 1;

  @override
  NewsSource read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsSource(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      url: fields[3] as String,
      category: fields[4] as String,
      language: fields[5] as String,
      country: fields[6] as String,
      imageUrl: fields[7] as String,
      time: fields[8] as String,
      author: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NewsSource obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.language)
      ..writeByte(6)
      ..write(obj.country)
      ..writeByte(7)
      ..write(obj.imageUrl)
      ..writeByte(8)
      ..write(obj.time)
      ..writeByte(9)
      ..write(obj.author);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsSourceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
