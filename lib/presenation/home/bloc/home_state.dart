part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {}

final class AddHabitSuccess extends HomeState {
  final String message;

  const AddHabitSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class AddHabitFailure extends HomeState {
  final String errorMessage;
  const AddHabitFailure({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class AddHabitLoading extends HomeState {}

final class ListHabitsLoading extends HomeState {}

final class ListHabitsError extends HomeState {
  final String error;

  const ListHabitsError({required this.error});
  @override
  List<Object> get props => [error];
}

final class ListHabitsSuccess extends HomeState {
  final List<Habits> habits;

  const ListHabitsSuccess({required this.habits});

  @override
  List<Object> get props => [habits];
}

final class ListHabitEmpty extends HomeState {
  @override
  List<Object> get props => [];
}
