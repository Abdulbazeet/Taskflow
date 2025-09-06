import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_flow/model/habits.dart';
import 'package:task_flow/presenation/home/home_repository/home_repository.dart';
import 'package:task_flow/presenation/today/today_notifier/today_notifier.dart';

final homeProvder = StateNotifierProvider<HomeNotifier, AsyncValue<void>>((
  ref,
) {
  final homRepo = ref.watch(homeRepoProvider);

  return HomeNotifier(homRepo, ref);
});

class HomeNotifier extends StateNotifier<AsyncValue<void>> {
  final HomeRepository homeRepository;
  final Ref ref;

  HomeNotifier(this.homeRepository, this.ref)
    : super(const AsyncValue.data(null));
  Future addHabit(Habits habits) async {
    state = AsyncValue.loading();
    try {
      await homeRepository.addHabits(
        habitName: habits.habitName,
        frequencyValue: habits.frequencyValue,
        frequencyUnit: habits.frequencyUnit,
        achievedValue: habits.achievedValue,
      );
      ref.invalidate(todayProvider);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e.toString(), st);
    }
  }
}
