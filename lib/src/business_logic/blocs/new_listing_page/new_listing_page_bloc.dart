import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_instrument/src/data/models/responses/main/category/category_model.dart';
import 'package:my_instrument/src/data/repositories/category_repository.dart';

part 'new_listing_page_event.dart';
part 'new_listing_page_state.dart';

class NewListingPageBloc extends Bloc<NewListingPageEvent, NewListingPageState> {
  final CategoryRepository categoryRepository;

  NewListingPageBloc({
    required this.categoryRepository
  }) : super(NewListingPageState.initial()) {
    on<NewListingPageEvent>(_handleNewListingPageEvent);
  }

  Future<void> _handleNewListingPageEvent(NewListingPageEvent event, Emitter<NewListingPageState> emit) async {
    /// Category loading
    try {
      if (event is GetCategoriesEvent) {
        if (!state.isLoadingCategories) {
          emit(state.copyWith(status: NewListingPageStatus.loadingCategories));

          var category = await categoryRepository
              .getAllCategoriesWithAllChildren();

          emit(state.copyWith(
              status: NewListingPageStatus.categoriesSuccess,
              category: category
          ));
        }
      }
    } catch (e) {
      emit(state.copyWith(status: NewListingPageStatus.categoriesFailure));
    }

    /// New listing creating
    try {
      if (event is CreateListingEvent) {
        if (!state.isLoading) {
          emit(state.copyWith(status: NewListingPageStatus.loading));

          // var response = await _listingRepository.createListing();

          emit(state.copyWith(status: NewListingPageStatus.success));
        }
      }
    } catch (e) {
      emit(state.copyWith(status: NewListingPageStatus.failure));
    }
  }
}
