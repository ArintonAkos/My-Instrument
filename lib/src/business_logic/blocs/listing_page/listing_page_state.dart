part of 'listing_page_bloc.dart';

enum ListingPageStatus { initial, loading, success, failure }

extension ListingPageStateX on ListingPageState {
  bool get isLoading => (status == ListingPageStatus.loading);
  bool get isSuccess => (status == ListingPageStatus.success);
  bool get isFailure => (status == ListingPageStatus.failure);
}

class ListingPageState extends Equatable {
  final ListingPageStatus status;
  final ListingModel? listing;

  const ListingPageState({
    required this.status,
    required this.listing
  });

  ListingPageState copyWith({
    ListingPageStatus? status,
    ListingModel? listing
  }) {
    return ListingPageState(
      status: status ?? this.status,
      listing: listing ?? this.listing
    );
  }

  factory ListingPageState.initial() {
    return const ListingPageState(
      status: ListingPageStatus.initial,
      listing: null
    );
  }

  @override
  String toString() {
    return '''
    ListingPageState {
      status: $status,
      listing: $listing
    }
    ''';
  }

  @override
  List<Object?> get props => [ status, listing ];
}