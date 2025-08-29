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
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Center(
                        child: Text(
                          date.day.toString(),
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(color: Colors.white),
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
                int currentRun = habitItems[index].achievedValue;
                Color iconColor = Theme.of(context).colorScheme.primary;
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Container(
                      height: 15.sh,
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
                                'Completed: $currentRun / ${habitItems[index].frequencyValue} ${habitItems[index].frequencyUnit}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (currentRun == 0) {
                                        setState(() {});
                                      } else {
                                        setState(() {
                                          currentRun--;
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(0.5.h),
                                      decoration: BoxDecoration(
                                        color: currentRun < 1
                                            ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withValues(alpha: .2)
                                            : Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                        borderRadius: BorderRadius.circular(
                                          1.sh,
                                        ),
                                      ),

                                      child: Icon(
                                        Icons.remove,
                                        size: 17.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 3.sw),
                                  Text(
                                    currentRun.toString(),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  SizedBox(width: 3.sw),
                                  InkWell(
                                    onTap: () {
                                      if (currentRun ==
                                          habitItems[index].frequencyValue) {
                                        setState(() {});
                                      } else {
                                        setState(() {
                                          currentRun++;
                                        });
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(0.5.h),
                                      decoration: BoxDecoration(
                                        color:
                                            currentRun ==
                                                habitItems[index].frequencyValue
                                            ? Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withValues(alpha: .2)
                                            : Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                        borderRadius: BorderRadius.circular(
                                          1.sh,
                                        ),
                                      ),

                                      child: Icon(
                                        Icons.add,
                                        size: 17.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 1.sh),

                          Expanded(
                            child: LinearProgressIndicator(
                              borderRadius: BorderRadius.circular(2.sh),

                              value:
                                  currentRun / habitItems[index].frequencyValue,
                              backgroundColor: Colors.grey.shade300,
                              color:
                                  currentRun == habitItems[index].frequencyValue
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
                                '${((currentRun / habitItems[index].frequencyValue) * 100).floor()} %',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
