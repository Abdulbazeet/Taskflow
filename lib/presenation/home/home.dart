import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
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
                  context: context,
                  
                  builder: (context) {
                    return BottomSheet(

                      onClosing: () {},
                    
                      builder: (context) {
                        return Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 5.sw),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 2.sh),
                              Text(
                                'Name of  Habit',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(height: 1.sh),
                              TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2.sh),
                                  ),
                                  hintText: 'eg. Drink Water',
                                ),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              SizedBox(height: 2.sh),
                            ],
                          ),
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
