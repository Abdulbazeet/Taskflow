// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Habits {
  final String habitName;
  final int frequencyValue;
  final String frequencyUnit;
  final int achievedValue;
  final String status;

  Habits({
    required this.habitName,
    required this.frequencyValue,
    required this.frequencyUnit,
    required this.achievedValue,
    required this.status,
  }); // "completed" or "incomplete"

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'habitName': habitName,
      'frequencyValue': frequencyValue,
      'frequencyUnit': frequencyUnit,
      'achievedValue': achievedValue,
      'status': status,
    };
  }

  factory Habits.fromMap(Map<String, dynamic> map) {
    return Habits(
      habitName: map['habitName'] as String,
      frequencyValue: map['frequencyValue'] as int,
      frequencyUnit: map['frequencyUnit'] as String,
      achievedValue: map['achievedValue'] as int,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Habits.fromJson(String source) =>
      Habits.fromMap(json.decode(source) as Map<String, dynamic>);
}
