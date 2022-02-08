part of 'product_list_page_bloc.dart';

abstract class ProductListPageEvent extends Equatable {
  const ProductListPageEvent();

  @override
  List<Object> get props => [];
}

class GetListings extends ProductListPageEvent {
  final GetListingsRequest request;

  const GetListings({
    required this.request
  });

  @override
  List<Object> get props => [ request ];
}