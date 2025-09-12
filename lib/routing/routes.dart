import 'package:go_router/go_router.dart';
import 'package:task_flow/presenation/add_habits/add-habits.dart';
import 'package:task_flow/presenation/home/home.dart';

class AppRoutes {
  static final GoRouter goRoouter = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const Home()),
      GoRoute(
        path: '/add-habits',
        builder: (context, state) => const AddHabits(),
      ),
    ],
  );
}
