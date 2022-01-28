import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_instrument/src/data/models/responses/main/category/category_model.dart';
import 'package:my_instrument/src/data/repositories/category_repository.dart';

part 'category_select_modal_event.dart';
part 'category_select_modal_state.dart';

class CategorySelectModalBloc extends Bloc<CategorySelectModalEvent, CategorySelectModalState> {
  final CategoryRepository categoryRepository;

  CategorySelectModalBloc({
    required this.categoryRepository
  }) : super(CategorySelectModalState.initial()) {
    on<CategorySelectModalEvent>(handleCategoryModalEvent);
  }

  Future<void> handleCategoryModalEvent(CategorySelectModalEvent event, Emitter<CategorySelectModalState> emit) async {
    if (event is LoadCategories) {
      emit(state.copyWith(status: CategorySelectModalStatus.loading));

      try {
        var categories = await categoryRepository.getCategoryWithChildren(event.categoryId);

        emit(state.copyWith(status: CategorySelectModalStatus.success, categories: categories));
      } catch (e) {
        emit(state.copyWith(status: CategorySelectModalStatus.failure, categories: []));
      }

    }
  }

}
