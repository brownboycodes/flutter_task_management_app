
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management_app/task_management_app.dart';

final filterStateProvider = StateNotifierProvider<FilterStateNotifier, SortOrder>((ref) {
  return FilterStateNotifier();
});

class FilterStateNotifier extends StateNotifier<SortOrder> {
  FilterStateNotifier() : super(SortOrder.defaultOrder);

  void updateSearchState(SortOrder sortOrder) {
    state = sortOrder;
  }

}

final searchKeywordProvider = StateNotifierProvider<SearchStateNotifier,String>((ref) => SearchStateNotifier());

class SearchStateNotifier extends StateNotifier<String> {
  SearchStateNotifier() : super('');

  void updateSearchState(String searchState) {
    state = searchState;
  }

}