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
  List<Habits> currentHabits = [];
  HomeBloc() : super(HomeInitial()) {
    on<AddHabit>(_addHabit);
    on<ListHabits>(_listHabiits);
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

      emit(
        AddHabitSuccess(
          message: ' ${event.habitName} has been added successfully',
        ),
      );
      final updatedHabits = await dbHelper.getAllHbits();
      currentHabits = updatedHabits;
      emit(ListHabitsSuccess(habits: updatedHabits));
    } catch (e) {
      emit(AddHabitFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _listHabiits(ListHabits event, Emitter<HomeState> emit) async {
    emit(ListHabitsLoading());
    try {
      final result = await dbHelper.getAllHbits();
      currentHabits = result; // Update current habits
      if (result.isEmpty) {
        emit(ListHabitEmpty());
      } else {
        emit(ListHabitsSuccess(habits: result));
      }
    } catch (e) {
      emit(ListHabitsError(error: e.toString()));
    }
  }
}
