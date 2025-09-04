part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

final class AddHabit extends HomeEvent {
  final String habitName;
  final int? frequencyValue;
  final String? frequencyUnit;
  int? achievedValue;

  AddHabit({
    required this.habitName,
    required this.frequencyValue,
    required this.frequencyUnit,
    required this.achievedValue,
  });
  @override
  List<Object?> get props => [
    habitName,
    frequencyValue,
    frequencyUnit,
    achievedValue,
  ];
}

final class ListHabits extends HomeEvent {}
