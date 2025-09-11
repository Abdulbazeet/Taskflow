import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:task_flow/model/habits.dart';
import 'package:task_flow/presenation/history/history.dart';
import 'package:task_flow/presenation/home/home_controller/home_notifier.dart';
import 'package:task_flow/presenation/settings/settings.dart';
import 'package:task_flow/presenation/stats/stats.dart';
import 'package:task_flow/presenation/today/today.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List _body = [Today(), Stats(), History(), Settings()];
  final List<String> _repeatMode = [
    'Every day',
    'Certain days',
    'Every certain days',
  ];
  final List<String> _frequency = ['Times per day', 'Hours per day'];
  String _repeat = 'Every day';
  final List<String> _days_of_the_week = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
  final List<String> _endDate = ['Never', 'After days', 'Specific date'];

  String _selectedEndDate = 'Never';
  final List<int?> _daysIndex = [];
  TimeOfDay? _chosenTIme;

  int _index = 0;
  String _selectedFrequency = 'Times per day';
  final TextEditingController _name = TextEditingController();
  final TextEditingController _repeatText = TextEditingController(text: '2');
  final TextEditingController _value = TextEditingController(text: '1');
  final TextEditingController _valueFrequency = TextEditingController(
    text: '1',
  );
  final startDate = DateFormat('MMM d, yyyy').format(DateTime.now()).toString();

  DateTime? _endPickedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body[_index],
      bottomNavigationBar: StylishBottomBar(
        items: [
          BottomBarItem(icon: Icon(Icons.home_rounded), title: Text('Home')),
          BottomBarItem(
            icon: Icon(Icons.bar_chart_rounded),
            title: Text('Stats'),
          ),
          BottomBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('History'),
          ),
          BottomBarItem(icon: Icon(Icons.settings), title: Text('Settings')),
        ],
        option: BubbleBarOptions(
          barStyle: BubbleBarStyle.horizontal,
          bubbleFillStyle: BubbleFillStyle.fill,
        ),

        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
      ),
      floatingActionButton: _index == 0
          ? FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  sheetAnimationStyle: AnimationStyle(
                    curve: ElasticInCurve(),
                    duration: Duration(seconds: 1),
                  ),

                  showDragHandle: true,
                  enableDrag: true,
                  context: context,

                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return BottomSheet(
                          onClosing: () {},

                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.sw,
                                vertical: 2.sh,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 2.sh),
                                  Center(
                                    child: Text(
                                      'ADD NEW HABIT',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  SizedBox(height: 2.sh),

                                  TextField(
                                    controller: _name,
                                    decoration: InputDecoration(
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          2.sh,
                                        ),
                                        borderSide: BorderSide(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          2.sh,
                                        ),
                                        borderSide: BorderSide(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                      ),
                                      hintText: 'Add Habit name',
                                    ),

                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium!,
                                  ),

                                  SizedBox(height: 2.sh),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Start Date',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                      Text(
                                        startDate.toString(),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.sh),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'End Date',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                      Spacer(),
                                      _selectedEndDate == 'After days'
                                          ? SizedBox(
                                              width: 8.sw,
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: _value,
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                  hintStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),

                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Theme.of(
                                                            context,
                                                          ).colorScheme.primary,
                                                        ),
                                                      ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(
                                                        context,
                                                      ).colorScheme.primary,
                                                    ),
                                                  ),
                                                  hintText: '0',
                                                ),
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.titleSmall!,
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                      _selectedEndDate == "Specific date"
                                          ? _endPickedDate == null
                                                ? Text(
                                                    DateFormat('MMM d, yyyy')
                                                        .format(DateTime.now())
                                                        .toString(),
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.bodySmall,
                                                  )
                                                : Text(
                                                    DateFormat('MMM d, yyyy')
                                                        .format(_endPickedDate!)
                                                        .toString(),
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.bodySmall,
                                                  )
                                          : SizedBox.shrink(),
                                      SizedBox(width: 3.sw),
                                      _selectedEndDate == "Specific date"
                                          ? ElevatedButton(
                                              onPressed: () async {
                                                DateTime? pickedDate =
                                                    await showDatePicker(
                                                      context: context,
                                                      firstDate: DateTime(1600),
                                                      lastDate: DateTime(2900),
                                                    );
                                                setState(() {
                                                  _endPickedDate = pickedDate;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withValues(alpha: .3),
                                                padding: EdgeInsets.all(1.sh),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadiusGeometry.circular(
                                                        1.sh,
                                                      ),
                                                ),
                                              ),
                                              child: Text(
                                                'Choose date',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall!
                                                    .copyWith(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            )
                                          : SizedBox.shrink(),

                                      SizedBox(width: 3.sw),
                                      DropdownButton<String>(
                                        value: _selectedEndDate,
                                        alignment:
                                            AlignmentGeometry.centerRight,
                                        isExpanded: false,
                                        isDense: true,
                                        items: _endDate
                                            .map(
                                              (e) => DropdownMenuItem<String>(
                                                value: e,
                                                child: Text(
                                                  e,
                                                  style: Theme.of(
                                                    context,
                                                  ).textTheme.bodySmall,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            if (value == 'After days') {
                                              _selectedEndDate = 'Every day';
                                            }
                                            _selectedEndDate = value!;
                                          });
                                        },
                                        underline: SizedBox.shrink(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.sh),
                                  _chosenTIme != null
                                      ? Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 3.sw,
                                            vertical: 2.sh,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              2.sw,
                                            ),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withValues(alpha: .3),
                                          ),

                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                MaterialLocalizations.of(
                                                  context,
                                                ).formatTimeOfDay(
                                                  _chosenTIme!,
                                                  alwaysUse24HourFormat:
                                                      MediaQuery.of(
                                                        context,
                                                      ).alwaysUse24HourFormat,
                                                ),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _chosenTIme = null;
                                                  });
                                                },
                                                child: Icon(Icons.close),
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                  _chosenTIme != null
                                      ? SizedBox(height: 2.sh)
                                      : SizedBox.shrink(),

                                  InkWell(
                                    onTap: () async {
                                      TimeOfDay?
                                      pickedTime = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        initialEntryMode:
                                            TimePickerEntryMode.input,
                                        builder: (context, child) {
                                          return MediaQuery(
                                            data: MediaQuery.of(context)
                                                .copyWith(
                                                  alwaysUse24HourFormat:
                                                      MediaQuery.of(
                                                        context,
                                                      ).alwaysUse24HourFormat,
                                                ),
                                            child: child!,
                                          );
                                        },
                                      );
                                      setState(() {
                                        _chosenTIme = pickedTime;
                                      });
                                    },
                                    child: Text(
                                      'Set Reminder',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                          ),
                                    ),
                                  ),
                                  SizedBox(height: 1.sh),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Frequency',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                      Spacer(),
                                      SizedBox(
                                        width: 8.sw,
                                        child: TextField(
                                          controller: _valueFrequency,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.normal,
                                                ),

                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                              ),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                              ),
                                            ),
                                            hintText: '0',
                                          ),
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleSmall!,
                                        ),
                                      ),
                                      SizedBox(width: 3.sw),
                                      DropdownButton<String>(
                                        value: _selectedFrequency,
                                        alignment:
                                            AlignmentGeometry.centerRight,
                                        isExpanded: false,
                                        isDense: true,
                                        items: _frequency
                                            .map(
                                              (e) => DropdownMenuItem<String>(
                                                value: e,
                                                child: Text(
                                                  e,
                                                  style: Theme.of(
                                                    context,
                                                  ).textTheme.bodySmall,
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedFrequency = value!;
                                          });
                                        },
                                        underline: SizedBox.shrink(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2.sh),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Repeat',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),

                                      SizedBox(width: 3.sw),

                                      _repeat == 'Certain days'
                                          ? Expanded(
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: List.generate(7, (
                                                    index,
                                                  ) {
                                                    return InkWell(
                                                      onTap: () {
                                                        if (_daysIndex.contains(
                                                          index,
                                                        )) {
                                                          setState(() {
                                                            _daysIndex.remove(
                                                              index,
                                                            );
                                                          });
                                                        } else {
                                                          setState(() {
                                                            _daysIndex.add(
                                                              index,
                                                            );
                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.all(
                                                          .3.sw,
                                                        ),
                                                        padding: EdgeInsets.all(
                                                          3.5.sw,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color:
                                                              _daysIndex
                                                                  .contains(
                                                                    index,
                                                                  )
                                                              ? Theme.of(
                                                                      context,
                                                                    )
                                                                    .colorScheme
                                                                    .primary
                                                              : Colors.white,
                                                          shape:
                                                              BoxShape.circle,
                                                          border:
                                                              !(_daysIndex
                                                                  .contains(
                                                                    index,
                                                                  ))
                                                              ? Border.all(
                                                                  color: Theme.of(
                                                                    context,
                                                                  ).colorScheme.primary,
                                                                )
                                                              : null,
                                                        ),
                                                        child: Text(
                                                          _days_of_the_week[index],
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall,
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                      _repeat == 'Every certain days'
                                          ? SizedBox(
                                              width: 8.sw,
                                              child: TextField(
                                                controller: _repeatText,
                                                textAlign: TextAlign.center,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  hintStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),

                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Theme.of(
                                                            context,
                                                          ).colorScheme.primary,
                                                        ),
                                                      ),
                                                  border: UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(
                                                        context,
                                                      ).colorScheme.primary,
                                                    ),
                                                  ),
                                                  hintText: '0',
                                                ),
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.titleSmall!,
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                      _selectedEndDate == 'After days'
                                          ? Text(
                                              _repeat,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodySmall,
                                            )
                                          : DropdownButton<String>(
                                              isExpanded: false,
                                              isDense: true,
                                              padding: EdgeInsets.all(0),
                                              value: _repeat,
                                              alignment:
                                                  AlignmentGeometry.centerRight,
                                              items: _repeatMode
                                                  .map(
                                                    (e) =>
                                                        DropdownMenuItem<
                                                          String
                                                        >(
                                                          value: e,
                                                          child: Text(
                                                            e,
                                                            style:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .textTheme
                                                                    .bodySmall,
                                                          ),
                                                        ),
                                                  )
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  _repeat = value!;
                                                });
                                              },
                                              underline: SizedBox.shrink(),
                                            ),
                                    ],
                                  ),

                                  SizedBox(height: 2.sh),
                                  Consumer(
                                    builder: (context, ref, child) {
                                      final state = ref.watch(homeProvder);

                                      ref.listen(homeProvder, (previous, next) {
                                        next.whenOrNull(
                                          data: (data) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Habit has been addedd successfully',
                                                ),
                                              ),
                                            );
                                            _name.clear();
                                            _endPickedDate = null;
                                            _chosenTIme = null;
                                            _value.text = '1';
                                            _repeat = 'Every day';
                                            _repeatText.text = '2';
                                            _selectedEndDate = 'Never';
                                            _selectedFrequency =
                                                'Times per day';
                                          },
                                          error: (error, stackTrace) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'An error occured: $error',
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      });

                                      return ElevatedButton(
                                        onPressed: () {
                                          if (_name.text.isEmpty) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'The habit name must not be empty',
                                                ),
                                              ),
                                            );
                                            return;
                                          } else {
                                            Habits habits = Habits(
                                              endPeriod: _selectedEndDate,
                                              endPeriodValue: int.parse(
                                                _value.text,
                                              ),
                                              endTime: _endPickedDate,
                                              reminderTime: _chosenTIme,
                                              repeatDays: _daysIndex,
                                              repeatPattern: int.parse(
                                                _repeatText.text,
                                              ),

                                              repeatMode: _repeat,
                                              startDateTime: DateTime.now(),
                                              habitName: _name.text,
                                              frequencyValue: int.parse(
                                                _valueFrequency.text,
                                              ),
                                              frequencyUnit: _selectedFrequency,
                                              achievedValue: 0,
                                            );
                                            ref
                                                .read(homeProvder.notifier)
                                                .addHabit(habits);
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(100.w, 6.h),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              2.sh,
                                            ),
                                          ),
                                          backgroundColor: state.when(
                                            data: (data) => Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                            error: (error, stackTrace) => Colors
                                                .red
                                                .withValues(alpha: .4),
                                            loading: () => Colors.grey,
                                          ),
                                        ),
                                        child: state.when(
                                          data: (data) => Text(
                                            'ADD HABIT',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          error: (error, stackTrace) =>
                                              SizedBox.shrink(),
                                          loading: () =>
                                              CircularProgressIndicator.adaptive(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          enableDrag: true,
                        );
                      },
                    );
                  },
                );
              },
              child: Icon(Icons.add),
            )
          : SizedBox.shrink(),
    );
  }
}
