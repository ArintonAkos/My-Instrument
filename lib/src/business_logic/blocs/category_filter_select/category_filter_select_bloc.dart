import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_instrument/src/data/models/responses/main/category/filter_model.dart';
import 'package:my_instrument/src/data/repositories/category_repository.dart';

part 'category_filter_select_event.dart';
part 'category_filter_select_state.dart';

class CategoryFilterSelectBloc extends Bloc<CategoryFilterSelectEvent, CategoryFilterSelectState> {
  final CategoryRepository categoryRepository;

  CategoryFilterSelectBloc({
    required this.categoryRepository
  }) : super(CategoryFilterSelectState.initial()) {
    on<CategoryFilterSelectEvent>(handleCategoryFilterSelectEvent);
  }

  Future<void> handleCategoryFilterSelectEvent(CategoryFilterSelectEvent event, Emitter<CategoryFilterSelectState> emit) async {
    if (event is LoadCategoryFilters) {
      emit(state.copyWith(status: CategoryFilterSelectStatus.loading));

      try {
        var categoryFilters = await categoryRepository.getCategoryFilters(event.categoryId);

        emit(state.copyWith(status: CategoryFilterSelectStatus.success, filters: categoryFilters));
      } catch (e) {
        emit(state.copyWith(status: CategoryFilterSelectStatus.failure, filters: []));
      }
    }
  }
}
