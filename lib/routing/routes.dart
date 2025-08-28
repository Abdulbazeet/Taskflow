import 'package:go_router/go_router.dart';
import 'package:task_flow/presenation/home/home.dart';

class AppRoutes {
  static final GoRouter goRoouter = GoRouter(
    routes: [GoRoute(path: '/home', builder: (context, state) => const Home())],
  );
}
