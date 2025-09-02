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

  const AddHabit({
    required this.habitName,
    required this.frequencyValue,
    required this.frequencyUnit,
  });
  @override
  List<Object?> get props => [habitName, frequencyValue, frequencyUnit];
}
