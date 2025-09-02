part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {}

final class AddHabitSuccess extends HomeState {}

final class AddHabitFailure extends HomeState {
  final String errorMessage;
  const AddHabitFailure({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

final class AddHabitLoading extends HomeState {}
