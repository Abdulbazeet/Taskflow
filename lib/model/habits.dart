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
  final List<int>? repeatDays; // Days of week [1,2,5]

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
    this.repeatDays,
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
    List<int>? repeatDays,
  }) {
    return Habits(
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
      repeatDays: repeatDays ?? this.repeatDays,
    );
  }

  /// ✅ Convert Habit → Map (for DB)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'habitName': habitName,
      'frequencyValue': frequencyValue,
      'frequencyUnit': frequencyUnit,
      'achievedValue': achievedValue,
      'startDateTime': startDateTime.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
      'endPeriod': endPeriod,
      'endPeriodValue': endPeriodValue,
      'reminderHour': reminderTime?.hour,
      'reminderMinute': reminderTime?.minute,
      'repeatMode': repeatMode,
      'repeatPattern': repeatPattern,
      'repeatDays': repeatDays != null ? repeatDays!.join(',') : null,
    };
  }

  /// ✅ Convert Map → Habit (from DB)
  factory Habits.fromMap(Map<String, dynamic> map) {
    return Habits(
      id: map['id'],
      habitName: map['habitName'],
      frequencyValue: map['frequencyValue'],
      frequencyUnit: map['frequencyUnit'],
      achievedValue: map['achievedValue'],
      startDateTime: DateTime.fromMillisecondsSinceEpoch(map['startDateTime']),
      endTime: map['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endTime'])
          : null,
      endPeriod: map['endPeriod'],
      endPeriodValue: map['endPeriodValue'],
      reminderTime:
          (map['reminderHour'] != null && map['reminderMinute'] != null)
          ? TimeOfDay(hour: map['reminderHour'], minute: map['reminderMinute'])
          : null,
      repeatMode: map['repeatMode'],
      repeatPattern: map['repeatPattern'],
      repeatDays: map['repeatDays'] != null && map['repeatDays'].isNotEmpty
          ? map['repeatDays'].split(',').map<int>((e) => int.parse(e)).toList()
          : null,
    );
  }
}
