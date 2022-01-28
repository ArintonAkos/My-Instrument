part of 'category_select_modal_bloc.dart';

abstract class CategorySelectModalEvent extends Equatable {
  const CategorySelectModalEvent();
}

class LoadCategories extends CategorySelectModalEvent {
  final int categoryId;

  const LoadCategories({
    required this.categoryId
  });

  @override
  List<Object> get props => [ categoryId ];
}
