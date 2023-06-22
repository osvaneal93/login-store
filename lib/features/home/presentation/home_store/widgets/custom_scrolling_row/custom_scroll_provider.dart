import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomScrollState {
  final List<String> items;
  final int index;
  CustomScrollState({required this.items, required this.index});

  CustomScrollState copyWith({
    List<String>? items,
    int? index,
  }) {
    return CustomScrollState(index: index ?? this.index, items: items ?? this.items);
  }
}

class CustomScrollStateProvider extends StateNotifier<CustomScrollState> {
  CustomScrollStateProvider(super.state);

  changeItemIndex(int index) {
    state = state.copyWith(index: index);
  }
}

final customScrollProvider = StateNotifierProvider<CustomScrollStateProvider, CustomScrollState>(
  (ref) => CustomScrollStateProvider(
    CustomScrollState(items: [], index: 0),
  ),
);
