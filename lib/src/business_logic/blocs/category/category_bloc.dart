import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_instrument/src/data/models/responses/main/category/category_model.dart';
import 'package:my_instrument/src/data/repositories/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc({
    required this.categoryRepository
  }) : super(CategoryState.initial()) {
    on<CategoryEvent>(handleEvent);
  }

  Future<void> handleEvent(CategoryEvent event, Emitter emit) async {
    if (event is LoadCategories || event is LoadBaseCategories) {
      await handleCategories(event, emit);
    }
  }

  Future<void> handleCategories(CategoryEvent event, Emitter emit) async {
    emit(state.copyWith(status: CategoryStatus.loading));

    try {
      var categories = await getCategories(event);

      emit(state.copyWith(
          status: CategoryStatus.success,
          categories: categories
      ));
    }
    catch (ex) {
      emit(state.copyWith(status: CategoryStatus.failure));
    }
  }

  Future<List<CategoryModel>> getCategories(CategoryEvent event) async {
    if (event is LoadCategories) {
      return await categoryRepository.getCategoryWithChildren(event.categoryId);
    } else if (event is LoadBaseCategories) {
      return await categoryRepository.getBaseCategoriesWithChildren();
    }

    return [];
  }
}
