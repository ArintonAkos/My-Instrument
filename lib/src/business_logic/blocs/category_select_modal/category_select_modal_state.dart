part of 'category_select_modal_bloc.dart';

enum CategorySelectModalStatus {
  initial,
  loading,
  success,
  failure,
}

extension CategorySelectModalStateX on CategorySelectModalState {
  bool get isLoading => (status == CategorySelectModalStatus.loading);
  bool get isSuccess => (status == CategorySelectModalStatus.success);
  bool get isFailure => (status == CategorySelectModalStatus.failure);
}

class CategorySelectModalState extends Equatable {
  final CategorySelectModalStatus status;
  final List<CategoryModel> categories;

  const CategorySelectModalState({
    required this.status,
    required this.categories
  });

  CategorySelectModalState copyWith({
    CategorySelectModalStatus? status,
    List<CategoryModel>? categories
  }) {
    return CategorySelectModalState(
      status: status ?? this.status,
      categories: categories ?? this.categories
    );
  }

  factory CategorySelectModalState.initial() {
    return const CategorySelectModalState(
        status: CategorySelectModalStatus.initial,
        categories: []
    );
  }

  @override
  String toString() {
    return '''
    CategorySelectModalState {
      status: $status,
      categories: ${categories.length}
    }
    ''';
  }

  @override
  List<Object> get props => [ status, categories ];
}


