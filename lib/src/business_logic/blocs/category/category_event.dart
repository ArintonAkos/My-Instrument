part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadCategories extends CategoryEvent {
  final int categoryId;

  const LoadCategories({
    required this.categoryId
  });

  @override
  List<Object> get props => [];
}