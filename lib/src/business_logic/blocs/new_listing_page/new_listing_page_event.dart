part of 'new_listing_page_bloc.dart';

abstract class NewListingPageEvent extends Equatable {
  const NewListingPageEvent();

  @override
  List<Object> get props => [];
}

class GetListings extends NewListingPageEvent {
  final GetListingsRequest request;

  const GetListings({
    required this.request
  });

  @override
  List<Object> get props => [ request ];
}