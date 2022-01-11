part of 'listing_page_bloc.dart';

abstract class ListingPageEvent extends Equatable {
  const ListingPageEvent();

  @override
  List<Object> get props => [];
}

class GetListings extends ListingPageEvent {
  final GetListingsRequest request;

  const GetListings({
    required this.request
  });

  @override
  List<Object> get props => [ request ];
}