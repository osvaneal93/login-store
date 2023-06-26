import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavBarState {
  final int currentPage;

  BottomNavBarState({required this.currentPage});
  BottomNavBarState copyWith({int? currentPage}) {
    return BottomNavBarState(currentPage: currentPage ?? this.currentPage);
  }
}

class BottomNavBarNotifier extends StateNotifier<BottomNavBarState> {
  BottomNavBarNotifier(super.state);

  void changeIndexPage(int index) {
    state = state.copyWith(currentPage: index);
  }
}

final bottomNavBarProvider = StateNotifierProvider<BottomNavBarNotifier, BottomNavBarState>(
  (ref) => BottomNavBarNotifier(
    BottomNavBarState(currentPage: 0),
  ),
);
