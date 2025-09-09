import 'package:task_flow/model/habits.dart';

class AppUtils {
  static List<Map<String, dynamic>> habits = [
    {
      "habitName": "Drink Water",
      "frequencyValue": 8,
      "frequencyUnit": "times per day",
      "achievedValue": 5,
      "status": "incomplete", // 5 < 8
    },
    {
      "habitName": "Morning Run",
      "frequencyValue": 3,
      "frequencyUnit": "days per week",
      "achievedValue": 3,
      "status": "completed", // 3 == 3
    },
    {
      "habitName": "Read Book",
      "frequencyValue": 2,
      "frequencyUnit": "hours per day",
      "achievedValue": 1,
      "status": "incomplete", // 1 < 2
    },
    {
      "habitName": "Meditation",
      "frequencyValue": 7,
      "frequencyUnit": "days per week",
      "achievedValue": 7,
      "status": "completed", // 7 == 7
    },
    {
      "habitName": "Coding Practice",
      "frequencyValue": 10,
      "frequencyUnit": "hours per week",
      "achievedValue": 6,
      "status": "incomplete", // 6 < 10
    },
  ];
  // static bool isDueToday(DateTime start, int repeatEvery, DateTime today) {
  //   final currentDate = DateTime(today.year, today.month, today.day);
  //   final startDate = DateTime(start.year, start.month, start.day);
  //   if (currentDate.isBefore(startDate)) return false;
  //   final diffference = currentDate.difference(startDate).inDays;
  //   return diffference % repeatEvery == 0;
  // }
  //   static bool isDueWeek(DateTime start, int repeatEvery, DateTime today) {
  //   final currentDate = DateTime(today.year, today.month, today.day);
  //   final startDate = DateTime(start.year, start.month, start.day);
  //   if (currentDate.isBefore(startDate)) return false;
  //   final diffference = currentDate.difference(startDate);
  //   return diffference % repeatEvery == 0;
  // }
  static bool isDueToday(Habits habits, DateTime currentDate) {
    if (habits.achievedValue >= habits.frequencyValue) return false;
    if (habits.endTime != null) {
      return habits.endTime!.isAfter(currentDate);
    } else {
      return true;
    }
  }
}
