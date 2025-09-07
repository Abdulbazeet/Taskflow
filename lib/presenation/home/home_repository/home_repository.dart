// ignore_for_file: use_build_context_synchronously

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
    required DateTime dateTime
  }) async {
    Habits newHabits = Habits(
      dateTime: dateTime ,
      habitName: habitName,
      frequencyValue: frequencyValue,
      frequencyUnit: frequencyUnit,
      achievedValue: achievedValue,
    );
    await dbHelper.addHabits(newHabits);
  }


}
