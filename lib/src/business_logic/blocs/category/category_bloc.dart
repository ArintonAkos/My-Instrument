import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_instrument/src/business_logic/blocs/home_page/home_page_bloc.dart';
import 'package:my_instrument/src/data/models/responses/main/category/category_model.dart';
import 'package:my_instrument/src/data/repositories/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  final HomePageBloc homePageBloc;
  final int? categoryId;
  late final StreamSubscription homePageSubscription;

  CategoryBloc({
    required this.categoryRepository,
    required this.homePageBloc,
    this.categoryId
  }) : super(CategoryState.initial()) {
    registerHomePageListener();
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

      homePageBloc.add(const HomePageLoaded());
    }
    catch (ex) {
      homePageBloc.add(const HomePageError());
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

  void registerHomePageListener() {
    homePageSubscription = homePageBloc.stream.listen((HomePageState homePageState) {
      if (homePageState.isReloading) {
        if (categoryId != null) {
          add(LoadCategories(categoryId: categoryId!));
        } else {
          add(const LoadBaseCategories());
        }
      }
    });
  }

  @override
  Future<void> close() {
    homePageSubscription.cancel();
    return super.close();
  }
}
