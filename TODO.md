# TODO: Integrate HomeBloc with Today.dart for Habit Display and Auto-Update

## Step 1: Modify HomeBloc to Reload Habits After Adding
- Update `_addHabit` method in `home_bloc.dart` to emit `LoadHabitsSuccess` with updated habits list after adding a new habit.
- This ensures auto-update by providing the latest habits list to the UI.

## Step 2: Refactor Today.dart to Use BlocBuilder
- Replace static `AppUtils.habits` with BlocBuilder listening to HomeBloc.
- Handle different states: HomeInitial, LoadHabitsSuccess, NoHabits, etc.
- Display habits from `state.habitsList` in the ListView.
- Add logic to trigger `loadAllHabits` event on widget init if needed (e.g., if HomeInitial has empty list).

## Step 3: Test and Verify Auto-Update
- Ensure that when a habit is added via FAB in home.dart, today.dart updates automatically.
- Verify that habits are displayed on app open.
- Handle edge cases like no habits or loading states.
