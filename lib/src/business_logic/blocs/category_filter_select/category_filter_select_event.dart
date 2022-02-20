part of 'category_filter_select_bloc.dart';

abstract class CategoryFilterSelectEvent extends Equatable {
  const CategoryFilterSelectEvent();
}

class LoadCategoryFilters extends CategoryFilterSelectEvent {
  final int categoryId;

  const LoadCategoryFilters({
    required this.categoryId
  });

  @override
  List<Object> get props => [ categoryId ];
}