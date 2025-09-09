// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class Habits {
  final String habitName;
  final int frequencyValue;
  final String frequencyUnit;
  final int achievedValue;
  final int? id;
  final DateTime startDateTime;
  final DateTime? endTime; // End date if specific
  final String? endPeriod; // "Never", "After days", "Specific date"
  final int? endPeriodValue; // e.g., 7 days, 3 weeks
  final TimeOfDay? reminderTime;
  final String repeatMode; // "Daily", "Certain days", etc.
  final int? repeatPattern; // e.g., every X days/weeks
  final List<int?> repeatDays; // Days of week [1,2,5]

  Habits({
    required this.habitName,
    required this.frequencyValue,
    required this.frequencyUnit,
    required this.achievedValue,
    this.id,
    required this.startDateTime,
    this.endTime,
    this.endPeriod,
    this.endPeriodValue,
    this.reminderTime,
    required this.repeatMode,
    this.repeatPattern,
    required this.repeatDays,
  });

  /// ✅ copyWith for immutability
  Habits copyWith({
    String? habitName,
    int? frequencyValue,
    String? frequencyUnit,
    int? achievedValue,
    int? id,
    DateTime? startDateTime,
    DateTime? endTime,
    String? endPeriod,
    int? endPeriodValue,
    TimeOfDay? reminderTime,
    String? repeatMode,
    int? repeatPattern,
   required List<int?> repeatDays,
  }) {
    return Habits(
      repeatDays: repeatDays,
      habitName: habitName ?? this.habitName,
      frequencyValue: frequencyValue ?? this.frequencyValue,
      frequencyUnit: frequencyUnit ?? this.frequencyUnit,
      achievedValue: achievedValue ?? this.achievedValue,
      id: id ?? this.id,
      startDateTime: startDateTime ?? this.startDateTime,
      endTime: endTime ?? this.endTime,
      endPeriod: endPeriod ?? this.endPeriod,
      endPeriodValue: endPeriodValue ?? this.endPeriodValue,
      reminderTime: reminderTime ?? this.reminderTime,
      repeatMode: repeatMode ?? this.repeatMode,
      repeatPattern: repeatPattern ?? this.repeatPattern,
    );
  }

  /// ✅ Convert Habit → Map (for DB)
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'habitName': habitName,
      'frequencyValue': frequencyValue,
      'frequencyUnit': frequencyUnit,
      'achievedValue': achievedValue,
      'id': id,
      'startDateTime': startDateTime.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
      'endPeriod': endPeriod,
      'endPeriodValue': endPeriodValue,
      'reminderHour': reminderTime?.hour,
      'reminderMinute': reminderTime?.minute,
      'repeatMode': repeatMode,
      'repeatPattern': repeatPattern,
      'repeatDays': repeatDays,
    };
  }

  /// ✅ Convert Map → Habit (from DB)
  factory Habits.fromMap(Map<String, dynamic> map) {
    return Habits(
      habitName: map['habitName'] as String,
      frequencyValue: map['frequencyValue'] as int,
      frequencyUnit: map['frequencyUnit'] as String,
      achievedValue: map['achievedValue'] as int,
      id: map['id'] != null ? map['id'] as int : null,
      startDateTime: DateTime.fromMillisecondsSinceEpoch(
        map['startDateTime'] as int,
      ),
      endTime: map['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int)
          : null,
      endPeriod: map['endPeriod'] != null ? map['endPeriod'] as String : null,
      endPeriodValue: map['endPeriodValue'] != null
          ? map['endPeriodValue'] as int
          : null,
       reminderTime:
          (map['reminderHour'] != null && map['reminderMinute'] != null)
          ? TimeOfDay(hour: map['reminderHour'], minute: map['reminderMinute'])
          : null,
      repeatMode: map['repeatMode'] as String,
      repeatPattern: map['repeatPattern'] != null
          ? map['repeatPattern'] as int
          : null,
      repeatDays: List<int?>.from((map['repeatDays'] as List<int?>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Habits.fromJson(String source) =>
      Habits.fromMap(json.decode(source) as Map<String, dynamic>);
}
