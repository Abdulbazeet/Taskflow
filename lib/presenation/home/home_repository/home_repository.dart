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
  }) async {
    Habits newHabits = Habits(
      habitName: habitName,
      frequencyValue: frequencyValue,
      frequencyUnit: frequencyUnit,
      achievedValue: achievedValue,
    );
    await dbHelper.addHabits(newHabits);
  }

  Future listHabits() async {
    final result = await dbHelper.getAllHbits();
    List<Habits> habits = result;
    return habits;
  }
}
