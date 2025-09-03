import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';
import 'package:task_flow/model/habits.dart';
import 'package:task_flow/presenation/home/bloc/home_bloc.dart';
import 'package:task_flow/routing/routes.dart';
import 'package:task_flow/theme/theme.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (p0, p1, p2) => MultiBlocProvider(
        providers: [BlocProvider(create: (context) => HomeBloc())],
        child: MaterialApp.router(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.lightTheme,
          routerConfig: AppRoutes.goRoouter,
        ),
      ),
    );
  }
}
