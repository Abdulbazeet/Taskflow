import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_flow/model/habits.dart';
import 'package:task_flow/presenation/home/home_repository/home_repository.dart';

final homeProvder =
    StateNotifierProvider<HomeNotifier, AsyncValue<List<Habits>>>((ref) {
      final homRepo = ref.watch(homeRepoProvider);
      return HomeNotifier(homRepo);
    });

class HomeNotifier extends StateNotifier<AsyncValue<List<Habits>>> {
  final HomeRepository homeRepository;

  HomeNotifier(this.homeRepository) : super(const AsyncValue.data([]));
  Future addHabit(Habits habits) async {
    state = AsyncValue.loading();
    try {
      await homeRepository.addHabits(
        habitName: habits.habitName,
        frequencyValue: habits.frequencyValue,
        frequencyUnit: habits.frequencyUnit,
        achievedValue: habits.achievedValue,
      );
      
      await listHabits();
    } catch (e, st) {
      state = AsyncValue.error(e.toString(), st);
    }
  }

  Future listHabits() async {
    state = AsyncValue.loading();
    try {
      final habits = await homeRepository.listHabits();
      state = AsyncValue.data(habits);
    } catch (e, st) {
      state = AsyncValue.error(e.toString(), st);
    }
  }
}
