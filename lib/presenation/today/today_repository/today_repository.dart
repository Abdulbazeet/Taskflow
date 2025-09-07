import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_flow/databsae/db.dart';
import 'package:task_flow/model/habits.dart';

final todayRepoProvider = Provider((ref) => TodayRepository());

class TodayRepository {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future listHabits() async {
    final result = await dbHelper.getAllHbits();
    List<Habits> habits = result;
    return habits;
  }

  Future updateCount(Habits habits) async {
    await dbHelper.updateHabit(habits);
    return habits;
  }

  // Future completedHabits() async {
  //   List<Habits> habits = await listHabits();
  //   return habits
  //       .where((element) => element.achievedValue == element.frequencyValue)
  //       .toList();
  // }
}
