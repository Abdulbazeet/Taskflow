// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habits.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitsAdapter extends TypeAdapter<Habits> {
  @override
  final int typeId = 0;

  @override
  Habits read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Habits(
      habitName: fields[0] as String,
      frequencyValue: fields[1] as int,
      frequencyUnit: fields[2] as String,
      achievedValue: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Habits obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.habitName)
      ..writeByte(1)
      ..write(obj.frequencyValue)
      ..writeByte(2)
      ..write(obj.frequencyUnit)
      ..writeByte(3)
      ..write(obj.achievedValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
