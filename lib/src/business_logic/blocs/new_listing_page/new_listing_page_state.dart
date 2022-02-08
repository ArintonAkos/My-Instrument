part of 'new_listing_page_bloc.dart';

enum NewListingPageStatus {
  initial,
  loading,
  loadingCategories,
  success,
  categoriesSuccess,
  categoriesFailure,
  failure
}

extension NewListingPageStateX on NewListingPageState {
  bool get isLoading => (status == NewListingPageStatus.loading);
  bool get isLoadingCategories => (status == NewListingPageStatus.loadingCategories);
  bool get isSuccess => (status == NewListingPageStatus.success);
  bool get isCategoriesSuccess => (status == NewListingPageStatus.categoriesSuccess);
  bool get isFailure => (status == NewListingPageStatus.failure);
  bool get isCategoriesFailure => (status == NewListingPageStatus.categoriesFailure);
}

class NewListingPageState extends Equatable {
  final NewListingPageStatus status;
  final CategoryModel? category;

  const NewListingPageState({
    required this.status,
    required this.category
  });

  factory NewListingPageState.initial() {
    return const NewListingPageState(
      status: NewListingPageStatus.initial,
      category: null
    );
  }

  NewListingPageState copyWith({
    NewListingPageStatus? status,
    CategoryModel? category
  }) {
    return NewListingPageState(
      status: status ?? this.status,
      category: category ?? this.category
    );
  }

  @override
  List<Object?> get props => [ status, category ];
}