// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddTaskModelAdapter extends TypeAdapter<AddTaskModel> {
  @override
  final int typeId = 0;

  @override
  AddTaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddTaskModel(
      fields[0] as String,
      fields[1] as DateTime,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddTaskModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj._title)
      ..writeByte(1)
      ..write(obj._startTime)
      ..writeByte(2)
      ..write(obj._notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddTaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
