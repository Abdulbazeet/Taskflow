// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Habits {
  final String habitName;
  final int frequencyValue;
  final String frequencyUnit;
  final int achievedValue;
  int? id;
  final DateTime dateTime;
  // final DateTime? endTime;
  // fial 

  Habits({
    required this.habitName,
    required this.frequencyValue,
    required this.frequencyUnit,
    required this.achievedValue,
    this.id,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'habitName': habitName,
      'frequencyValue': frequencyValue,
      'frequencyUnit': frequencyUnit,
      'achievedValue': achievedValue,
      'id': id,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  factory Habits.fromMap(Map<String, dynamic> map) {
    return Habits(
      habitName: map['habitName'] as String,
      frequencyValue: map['frequencyValue'] as int,
      frequencyUnit: map['frequencyUnit'] as String,
      achievedValue: map['achievedValue'] as int,
      id: map['id'] != null ? map['id'] as int : null,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Habits.fromJson(String source) =>
      Habits.fromMap(json.decode(source) as Map<String, dynamic>);

  Habits copyWith({
    String? habitName,
    int? frequencyValue,
    String? frequencyUnit,
    int? achievedValue,
    int? id,
    DateTime? dateTime,
  }) {
    return Habits(
      habitName: habitName ?? this.habitName,
      frequencyValue: frequencyValue ?? this.frequencyValue,
      frequencyUnit: frequencyUnit ?? this.frequencyUnit,
      achievedValue: achievedValue ?? this.achievedValue,
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
