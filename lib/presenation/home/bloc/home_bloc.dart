import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_flow/databsae/db.dart';
import 'package:task_flow/model/habits.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  HomeBloc() : super(HomeInitial()) {
    on<AddHabit>(_addHabit);
  }
  Future<void> _addHabit(AddHabit event, Emitter<HomeState> emit) async {
    emit(AddHabitLoading());
    try {
      List<Habits> habitsList = [];
      Habits newHabit = Habits(
        habitName: event.habitName,
        frequencyValue: event.frequencyValue!,
        frequencyUnit: event.frequencyUnit!,
        achievedValue: event.achievedValue!,
      );
      await dbHelper.addHabits(newHabit);

      emit(AddHabitSuccess());
    } catch (e) {
      emit(AddHabitFailure(errorMessage: e.toString()));
    }
  }
}
