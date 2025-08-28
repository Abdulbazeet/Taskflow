import 'package:flutter/material.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:task_flow/presenation/history/history.dart';
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
  int _index = 0;
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
        option: BubbleBarOptions(),
        
        currentIndex: _index,
        onTap: (value) {
          _index = value;
        },
      ),
    );
  }
}
