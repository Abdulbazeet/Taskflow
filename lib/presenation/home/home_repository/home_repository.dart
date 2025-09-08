// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_flow/databsae/db.dart';
import 'package:task_flow/model/habits.dart';

final homeRepoProvider = Provider((ref) {
  return HomeRepository();
});

class HomeRepository {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<void> addHabits({
    required String habitName,
    required int frequencyValue,
    required String frequencyUnit,
    required int achievedValue,
    required DateTime startDateTime,
    required DateTime? endTime,
    required String? endPeriod,
    required int? endPeriodValue,
    required TimeOfDay? reminderTime,
    required String repeatMode,
    required int? repeatPattern,
    required List<int>? repeatDays,
  }) async {
    Habits newHabits = Habits(
      repeatMode: repeatMode,
      endPeriod: endPeriod,
      endPeriodValue: endPeriodValue,
      endTime: endTime,
      reminderTime: reminderTime,
      repeatDays: repeatDays,
      repeatPattern: repeatPattern,

      startDateTime: startDateTime,
      habitName: habitName,
      frequencyValue: frequencyValue,
      frequencyUnit: frequencyUnit,
      achievedValue: achievedValue,
    );
    await dbHelper.addHabits(newHabits);
  }
}
