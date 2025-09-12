import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
  List<int?> _daysIndex = [];
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
                context.push('/add-habits');

                // showModalBottomSheet(
                //   isScrollControlled: true,
                //   sheetAnimationStyle: AnimationStyle(
                //     curve: ElasticInCurve(),
                //     duration: Duration(seconds: 1),
                //   ),

                //   showDragHandle: true,
                //   enableDrag: true,
                //   context: context,

                //   builder: (context) {
                //     return StatefulBuilder(
                //       builder: (context, setState) {
                //         return BottomSheet(
                //           onClosing: () {},

                //           builder: (context) {
                //             return
                //           },
                //           enableDrag: true,
                //         );
                //       },
                //     );
                //   },
                // );
              },
              child: Icon(Icons.add),
            )
          : SizedBox.shrink(),
    );
  }
}
