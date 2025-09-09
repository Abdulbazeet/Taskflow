import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_flow/presenation/today/today_notifier/today_notifier.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  DateTime? _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History', style: Theme.of(context).textTheme.bodyLarge),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 2.sh),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(3.h),
                ),
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),

                child: TableCalendar(
                  focusedDay: _focusedDay!,
                  firstDay: DateTime(1999),
                  lastDay: DateTime(2100),
                  calendarFormat: CalendarFormat.month,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,

                    leftChevronPadding: EdgeInsets.zero,
                    rightChevronPadding: EdgeInsets.zero,
                    // headerPadding: EdgeInsets.only(bottom: 1.sh),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(decoration: BoxDecoration()),
                  daysOfWeekHeight: 6.h,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });
                  },

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
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      );
                    },
                    selectedBuilder: (context, day, focusedDay) {
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: .3),
                        ),
                        child: Center(
                          child: Text(
                            day.day.toString(),
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      );
                    },
                    defaultBuilder: (context, day, focusedDay) {
                      return Center(
                        child: Text(
                          day.day.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 2.sh),
              Text('All Habits', style: Theme.of(context).textTheme.bodyMedium),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(todayProvider);
                    final currentHabits = state.whenData(
                      (allHabits) => allHabits
                          .where(
                            (habit) =>
                                !(habit.startDateTime.isAfter(_focusedDay!)),
                          )
                          .toList(),
                    );
                    return currentHabits.when(
                      data: (data) {
                        if (data.isEmpty) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(height: 20.sp),
                              Center(
                                child: Text(
                                  "No habits on this day!",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            // physics: NeverScrollableScrollPhysics(),
                            itemCount: data.length,

                            itemBuilder: (context, index) {
                              final habitItems = data;

                              int currentRun = habitItems[index].achievedValue;

                              return StatefulBuilder(
                                builder: (context, setState) {
                                  return Container(
                                    height: 13.5.sh,
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surface,

                                      borderRadius: BorderRadius.circular(3.h),
                                    ),
                                    margin: EdgeInsets.symmetric(
                                      vertical: 1.sh,
                                    ),

                                    width: 100.w,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 3.sw,
                                      vertical: 2.sh,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [
                                        Text(
                                          habitItems[index].habitName,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                        SizedBox(height: 1.sh),
                                        Row(
                                          children: [
                                            Text(
                                              'Completed: $currentRun / ${habitItems[index].frequencyValue} ${habitItems[index].frequencyUnit}',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodySmall,
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                        SizedBox(height: 1.sh),

                                        Expanded(
                                          child: LinearProgressIndicator(
                                            borderRadius: BorderRadius.circular(
                                              2.sh,
                                            ),

                                            value:
                                                currentRun /
                                                habitItems[index]
                                                    .frequencyValue,
                                            backgroundColor:
                                                Colors.grey.shade300,
                                            color:
                                                currentRun ==
                                                    habitItems[index]
                                                        .frequencyValue
                                                ? Theme.of(
                                                    context,
                                                  ).colorScheme.primary
                                                : Colors.blue,
                                          ),
                                        ),
                                        SizedBox(height: 1.sh),

                                        Row(
                                          children: [
                                            Text(
                                              'Progress',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodySmall,
                                            ),
                                            Spacer(),
                                            Text(
                                              '${((currentRun / habitItems[index].frequencyValue) * 100).floor()} %',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodySmall,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }
                      },
                      error: (error, stackTrace) => Center(
                        child: Text(
                          '${error.toString()}, ${stackTrace.toString()}',
                        ),
                      ),
                      loading: () => Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(height: 20.sp),
                          Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
