import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_flow/model/habits.dart';
import 'package:task_flow/presenation/today/today_repository/today_repository.dart';

final todayProvider =
    StateNotifierProvider<TodayNotifier, AsyncValue<List<Habits>>>((ref) {
      final todayRepo = ref.watch(todayRepoProvider);
      return TodayNotifier(todayRepository: todayRepo);
    });

class TodayNotifier extends StateNotifier<AsyncValue<List<Habits>>> {
  final TodayRepository todayRepository;

  TodayNotifier({required this.todayRepository})
    : super(const AsyncValue.loading()) {
    listHabits();
  }
  Future listHabits() async {
    state = AsyncValue.loading();
    try {
      final habits = await todayRepository.listHabits();
      if (habits != []) {
        state = AsyncValue.data(habits);
      } else {
        state = AsyncValue.data([]);
      }
    } catch (e, st) {
      state = AsyncValue.error(e.toString(), st);
    }
  }

  Future updateHabit(Habits habit) async {
    try {
      await todayRepository.updateCount(habit);
      final habits = await todayRepository.listHabits();

      state = AsyncValue.data(habits);
    } catch (e, st) {
      state = AsyncValue.error(e.toString(), st);
    }
  }

  Future deleteHabit(Habits habits) async {
    state = AsyncValue.loading();
    try {
      final delete = await todayRepository.deleteHabit(habits);
      final listHabit = await todayRepository.listHabits();
      state = AsyncValue.data(listHabit);
    } catch (e, st) {
      state = AsyncValue.error(e.toString(), st);
    }
  }

  // Future completedHabits() async {
  //   // state = AsyncValue.loading();
  //   // try {
  //   //   final completedHabit = await todayRepository.completedHabits();
  //   //   if (completedHabit != []) {
  //   //     state = AsyncValue.data(completedHabit);
  //   //   } else {
  //   //     state = AsyncValue.data([]);
  //   //   }
  //   // } catch (e, st) {
  //   //   state = AsyncValue.error(e.toString(), st);
  //   // }
  //   return state.valueOrNull.where((element) => ,).toList() ?? [];
  // }
}
