import 'package:task_flow/model/habits.dart';

class AppUtils {
  // }
  static bool isDueToday(Habits habits, DateTime currentDate) {
    if (habits.achievedValue >= habits.frequencyValue) return false;
    if (habits.endTime != null) {
      switch (habits.repeatMode) {
        case 'Every day':
          return habits.endTime!.isAfter(currentDate);

        case 'Certain days':
          if (habits.endTime!.isBefore(currentDate)) return false;
          return habits.repeatDays.contains((currentDate.weekday + 1));
        case "Every certain days":
          if (habits.endTime!.isBefore(currentDate)) return false;
          final difference = currentDate
              .difference(habits.startDateTime)
              .inDays;
          return difference % habits.repeatPattern! == 0;
      }
    } else {
      switch (habits.endPeriod) {
        case "Never":
          switch (habits.repeatMode) {
            case 'Every day':
              return true;
            case 'Certain days':
              return habits.repeatDays.contains((currentDate.weekday + 1));
            case "Every certain days":
              if (habits.repeatMode == 'Every day') {
                final difference = currentDate
                    .difference(habits.startDateTime)
                    .inDays;
                return difference % habits.repeatPattern! == 0;
              }
          }

        case 'After days':
          final end = habits.startDateTime.add(
            Duration(days: habits.endPeriodValue!),
          );
          // if (end.isBefore(currentDate)) return false;
          // final difference = currentDate
          //     .difference(habits.startDateTime)
          //     .inDays;
          // return difference % habits.endPeriodValue! == 0;
          return end.isBefore(currentDate);
        case 'After weeks':
          switch (habits.repeatMode) {
            case 'Every day':
              final pastWeeks =
                  currentDate.difference(habits.startDateTime).inDays / 7;
              return (pastWeeks > habits.endPeriodValue!);

            case 'Certain days':
              final pastWeeks =
                  currentDate.difference(habits.startDateTime).inDays / 7;
              if (pastWeeks > habits.endPeriodValue!) return false;
              return habits.repeatDays.contains((currentDate.weekday + 1));
            case "Every certain days":
              final pastWeeks =
                  currentDate.difference(habits.startDateTime).inDays / 7;
              final pastDays = currentDate
                  .difference(habits.startDateTime)
                  .inDays;
              if (pastWeeks > habits.endPeriodValue!) return false;
              return pastDays % habits.repeatPattern! == 0;
          }

        default:
          return false;
      }
      // if (habits.endPeriod == 'Never') return true;

      // return true;
    }
    throw Exception("Unhandled habit repeatMode/endPeriod case");
  }

  static bool historyIsDueToday(Habits habits, DateTime focusedDay) {
    if ((habits.startDateTime.isAfter(focusedDay))) return false;
    if (habits.endTime != null) {
      switch (habits.repeatMode) {
        case 'Every day':
          return habits.endTime!.isAfter(focusedDay);

        case 'Certain days':
          if (habits.endTime!.isBefore(focusedDay)) return false;
          return habits.repeatDays.contains((focusedDay.weekday + 1));
        case "Every certain days":
          if (habits.endTime!.isBefore(focusedDay)) return false;
          final difference = focusedDay
              .difference(habits.startDateTime)
              .inDays;
          return difference % habits.repeatPattern! == 0;
      }
    } else {
      switch (habits.endPeriod) {
        case "Never":
          switch (habits.repeatMode) {
            case 'Every day':
              return true;
            case 'Certain days':
              return habits.repeatDays.contains((focusedDay.weekday + 1));
            case "Every certain days":
              if (habits.repeatMode == 'Every day') {
                final difference = focusedDay
                    .difference(habits.startDateTime)
                    .inDays;
                return difference % habits.repeatPattern! == 0;
              }
          }

        case 'After days':
          final end = habits.startDateTime.add(
            Duration(days: habits.endPeriodValue!),
          );
          // if (end.isBefore(currentDate)) return false;
          // final difference = currentDate
          //     .difference(habits.startDateTime)
          //     .inDays;
          // return difference % habits.endPeriodValue! == 0;
          return end.isBefore(focusedDay);
        case 'After weeks':
          switch (habits.repeatMode) {
            case 'Every day':
              final pastWeeks =
                  focusedDay.difference(habits.startDateTime).inDays / 7;
              return (pastWeeks > habits.endPeriodValue!);

            case 'Certain days':
              final pastWeeks =
                  focusedDay.difference(habits.startDateTime).inDays / 7;
              if (pastWeeks > habits.endPeriodValue!) return false;
              return habits.repeatDays.contains((focusedDay.weekday + 1));
            case "Every certain days":
              final pastWeeks =
                  focusedDay.difference(habits.startDateTime).inDays / 7;
              final pastDays = focusedDay
                  .difference(habits.startDateTime)
                  .inDays;
              if (pastWeeks > habits.endPeriodValue!) return false;
              return pastDays % habits.repeatPattern! == 0;
          }

        default:
          return false;
      }
      // if (habits.endPeriod == 'Never') return true;

      // return true;
    }
    // if (habits.endTime != null) {
    //   switch (habits.repeatMode) {
    //     case 'Every day':
    //       return habits.endTime!.isAfter(focusedDay);

    //     case 'Certain days':
    //       if (habits.endTime!.isBefore(focusedDay)) return false;
    //       return habits.repeatDays.contains((focusedDay.weekday + 1));
    //     case "Every certain days":
    //       if (habits.endTime!.isBefore(focusedDay)) return false;
    //       final difference = focusedDay.difference(habits.startDateTime).inDays;
    //       return difference % habits.repeatPattern! == 0;
    //   }
    // } else {
    //   switch (habits.endPeriod) {
    //     case "Never":
    //       switch (habits.repeatMode) {
    //         case 'Every day':
    //           return true;
    //         case 'Certain days':
    //           return habits.repeatDays.contains((focusedDay.weekday + 1));
    //         case "Every certain days":
    //           final difference = focusedDay
    //               .difference(habits.startDateTime)
    //               .inDays;
    //           return difference % habits.repeatPattern! == 0;
    //       }

    //     case 'After days':
    //       final end = habits.startDateTime.add(
    //         Duration(days: habits.endPeriodValue!),
    //       );
    //       if (end.isBefore(focusedDay)) return false;
    //       final difference = focusedDay.difference(habits.startDateTime).inDays;
    //       return difference % habits.endPeriodValue! == 0;
    //     case 'After weeks':
    //       switch (habits.repeatMode) {
    //         case 'Every day':
    //           final pastWeeks =
    //               focusedDay.difference(habits.startDateTime).inDays / 7;
    //           if (pastWeeks > habits.endPeriodValue!) return false;
    //           return true;
    //         case 'Certain days':
    //           final pastWeeks =
    //               focusedDay.difference(habits.startDateTime).inDays / 7;
    //           if (pastWeeks > habits.endPeriodValue!) return false;
    //           return habits.repeatDays.contains((focusedDay.weekday + 1));
    //         case "Every certain days":
    //           final pastWeeks =
    //               focusedDay.difference(habits.startDateTime).inDays / 7;
    //           final pastDays = focusedDay
    //               .difference(habits.startDateTime)
    //               .inDays;
    //           if (pastWeeks > habits.endPeriodValue!) return false;
    //           return pastDays % habits.repeatPattern! == 0;
    //       }

    //     default:
    //       return false;
    //   }
    //   // if (habits.endPeriod == 'Never') return true;

    //   // return true;
    // }
    throw Exception("Unhandled habit repeatMode/endPeriod case");
  }
}
