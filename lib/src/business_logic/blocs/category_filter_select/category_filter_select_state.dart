part of 'category_filter_select_bloc.dart';

enum CategoryFilterSelectStatus {
  initial,
  loading,
  success,
  failure
}

extension CategoryFilterSelectStateX on CategoryFilterSelectState {
  bool get isLoading => (status == CategoryFilterSelectStatus.loading);
  bool get isSuccess => (status == CategoryFilterSelectStatus.success);
  bool get isFailure => (status == CategoryFilterSelectStatus.failure);
}

class CategoryFilterSelectState extends Equatable {
  final CategoryFilterSelectStatus status;
  final List<FilterModel> filters;

  const CategoryFilterSelectState({
    required this.status,
    required this.filters
  });

  CategoryFilterSelectState copyWith({
    CategoryFilterSelectStatus? status,
    List<FilterModel>? filters
  }) => CategoryFilterSelectState(
    status: status ?? this.status,
    filters: filters ?? this.filters
  );

  factory CategoryFilterSelectState.initial() =>
    const CategoryFilterSelectState(
      status: CategoryFilterSelectStatus.initial,
      filters: []
    );

  @override
  String toString() {
    return '''
      CategoryFilterSelectState {
        status: $status,
        filters: ${filters.length}
      }
    ''';
  }

  @override
  List<Object> get props => [ status, filters ];
}
