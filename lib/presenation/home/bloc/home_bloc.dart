import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:task_flow/model/habits.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<AddHabit>(_addHabit);
  }
  Future<void> _addHabit(AddHabit event, Emitter<HomeState> emit) async {
    emit(AddHabitLoading());
    try {
      await Future.delayed(const Duration(seconds: 4));
      List<Habits> habitsList = [];
      Habits newHabit = Habits(
        habitName: event.habitName,
        frequencyValue: event.frequencyValue!,
        frequencyUnit: event.frequencyUnit!,
        achievedValue: 0,
      );
      habitsList.add(newHabit);
      final box = Hive.box('habits_box');
      box.add(newHabit);

      emit(AddHabitSuccess());
    } catch (e) {
      emit(AddHabitFailure(errorMessage: e.toString()));
    }
  }
}
