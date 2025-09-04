// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Habits {
  final String habitName;
  final int frequencyValue;
  final String frequencyUnit;
  final int achievedValue;
  int? id;

  Habits({
    required this.habitName,
    required this.frequencyValue,
    required this.frequencyUnit,
    required this.achievedValue,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'habitName': habitName,
      'frequencyValue': frequencyValue,
      'frequencyUnit': frequencyUnit,
      'achievedValue': achievedValue,
      'id': id,
    };
  }

  factory Habits.fromMap(Map<String, dynamic> map) {
    return Habits(
      id: map['id'] as int,
      habitName: map['habitName'] as String,
      frequencyValue: map['frequencyValue'] as int,
      frequencyUnit: map['frequencyUnit'] as String,
      achievedValue: map['achievedValue'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Habits.fromJson(String source) =>
      Habits.fromMap(json.decode(source) as Map<String, dynamic>);
}
