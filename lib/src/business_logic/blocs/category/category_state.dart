part of 'category_bloc.dart';

enum CategoryStatus { initial, loading, success, failure }

extension CategoryStateX on CategoryState {
  bool get isLoading => (status == CategoryStatus.loading);
  bool get isSuccess => (status == CategoryStatus.success);
  bool get isFailure => (status == CategoryStatus.failure);
}

class CategoryState extends Equatable {
  final CategoryStatus status;
  final List<CategoryModel> categories;

  const CategoryState({
    required this.status,
    required this.categories
  });

  CategoryState copyWith({
    CategoryStatus? status,
    List<CategoryModel>? categories
  }) {
    return CategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories
    );
  }

  factory CategoryState.initial() {
    return const CategoryState(
      status: CategoryStatus.initial,
      categories: []
    );
  }

  @override
  String toString() {
    return '''
    CategoryState {
      status: $status,
      categories: ${categories.length}
    }
    ''';
  }

  @override
  List<Object> get props => [ status, categories ];
}
