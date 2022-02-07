part of 'new_listing_page_bloc.dart';

enum ListingPageStatus {
  initial,
  success,
  failure
}

class NewListingPageState extends Equatable {
  final List<ListingModel> listings;
  late final FilterData filterData;
  final ListingPageStatus status;
  final bool hasReachedMax;

  NewListingPageState({
    this.listings = const <ListingModel>[],
    this.status = ListingPageStatus.initial,
    this.hasReachedMax = false,
    FilterData? filterData,
  }) {
    this.filterData = filterData ?? FilterData.initial();
  }

  NewListingPageState copyWith({
    ListingPageStatus? status,
    List<ListingModel>? listings,
    FilterData? filterData,
    bool? hasReachedMax,
  }) {
    return NewListingPageState(
      listings: listings ?? this.listings,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      filterData: filterData ?? this.filterData
    );
  }


  @override
  String toString() {
    return '''ListingPageState {
      status: $status,
      filterData: $filterData,
      hasReachedMax: $hasReachedMax,
      listings: ${listings.length},
    }''';
  }

  @override
  List<Object> get props => [listings, filterData, status, hasReachedMax ];
}
