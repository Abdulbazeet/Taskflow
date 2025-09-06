import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:task_flow/model/habits.dart';
import 'package:task_flow/presenation/history/history.dart';
import 'package:task_flow/presenation/home/home_controller/home_notifier.dart';
import 'package:task_flow/presenation/home/home_repository/home_repository.dart';
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
  final List<String> _frequency = [
    'times per day',
    'hours per day',

    'days per week',
  ];
  int _index = 0;
  String _selectedFrequency = 'times per day';
  final TextEditingController _habitNameController = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _value = TextEditingController(text: '1');
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
            title: Text('Histoy'),
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
                                    children: [
                                      Text(
                                        'Add frequency',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                      Spacer(),

                                      SizedBox(
                                        width: 8.sw,
                                        child: TextField(
                                          controller: _value,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
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
                                          ).textTheme.bodyMedium!,
                                        ),
                                      ),
                                      SizedBox(width: 4.sw),
                                      DropdownButton<String>(
                                        items: _frequency
                                            .map(
                                              (e) => DropdownMenuItem<String>(
                                                value: e,
                                                child: Text(
                                                  e,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedFrequency = value!;
                                          });
                                        },
                                        value: _selectedFrequency,
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
                                            _value.text = '1';
                                            _selectedFrequency =
                                                'times per day';
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
                                              habitName: _name.text,
                                              frequencyValue: int.parse(
                                                _value.text,
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
