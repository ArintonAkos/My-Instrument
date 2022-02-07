part of 'listing_page_bloc.dart';

abstract class ListingPageEvent extends Equatable {
  const ListingPageEvent();
}

class LoadListingEvent extends ListingPageEvent {
  final String listingId;

  const LoadListingEvent({
    required this.listingId
  });

  @override
  List<Object> get props => [ listingId ];
}