import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_flow/model/habits.dart';
import 'package:task_flow/utils/utils.dart';

class Today extends StatefulWidget {
  const Today({super.key});

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
  final now = DateFormat('EEEE d MMMM y').format(DateTime.now()).toString();
  DateTime selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.h),
            Text('WELCOME BACK', style: Theme.of(context).textTheme.bodySmall),
            Text('OLATUNJI', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          children: [
            SizedBox(height: 2.sh),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(3.h),
              ),
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),

              child: TableCalendar(
                focusedDay: DateTime.now(),
                firstDay: DateTime(1999),
                lastDay: DateTime(2100),
                calendarFormat: CalendarFormat.week,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  leftChevronIcon: SizedBox.shrink(),
                  rightChevronIcon: SizedBox.shrink(),
                  leftChevronPadding: EdgeInsets.zero,
                  headerPadding: EdgeInsets.only(bottom: 1.sh),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(decoration: BoxDecoration()),
                daysOfWeekHeight: 6.h,

                calendarBuilders: CalendarBuilders(
                  todayBuilder: (context, date, events) {
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.greenAccent,
                      ),
                      child: Center(
                        child: Text(
                          date.day.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    );
                  },
                  defaultBuilder: (context, day, focusedDay) {
                    if (day.isBefore(focusedDay)) {
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.remove,
                            color: Colors.grey,
                            size: 20.sp,
                          ),
                        ),
                      );
                    }
                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade300,
                      ),
                      child: Center(
                        child: Text(
                          day.day.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 3.sh),
            Text(
              "Today's Tasks",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: AppUtils.habits.length,

              itemBuilder: (context, index) {
                List<Habits> habitItems = [];
                final List habit = AppUtils.habits;
                habitItems = habit.map((e) => Habits.fromMap(e)).toList();
                return Container(
                  height: 14.sh,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,

                    borderRadius: BorderRadius.circular(3.h),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 1.sh),

                  width: 100.w,
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.sw,
                    vertical: 2.sh,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        habitItems[index].habitName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(height: 1.sh),
                      Row(
                        children: [
                          Text(
                            'Completed: ${habitItems[index].achievedValue} / ${habitItems[index].frequencyValue} ${habitItems[index].frequencyUnit}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      SizedBox(height: 1.sh),

                      Expanded(
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(2.sh),

                          value:
                              habitItems[index].achievedValue /
                              habitItems[index].frequencyValue,
                          backgroundColor: Colors.grey.shade300,
                          color: habitItems[index].status == "completed"
                              ? Colors.green
                              : Colors.blue,
                        ),
                      ),
                      SizedBox(height: 1.sh),

                      Row(
                        children: [
                          Text(
                            'Progress',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Spacer(),
                          Text(
                            '${(habitItems[index].achievedValue / habitItems[index].frequencyValue) * 100} %',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
