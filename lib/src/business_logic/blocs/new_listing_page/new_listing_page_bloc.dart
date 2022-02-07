import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_instrument/src/data/models/view_models/filter_data.dart';
import 'package:my_instrument/src/data/models/requests/main/listing/get_listings_request.dart';
import 'package:my_instrument/src/data/models/responses/main/listing/listing_model.dart';
import 'package:my_instrument/src/data/repositories/listing_repository.dart';

part 'new_listing_page_event.dart';
part 'new_listing_page_state.dart';

class NewListingPageBloc extends Bloc<NewListingPageEvent, NewListingPageState> {
  final ListingRepository listingRepository;

  NewListingPageBloc({
    required this.listingRepository
  }) : super(NewListingPageState()) {
    on<NewListingPageEvent>(_onListingPageEvent);
  }

  Future<void> _onListingPageEvent(NewListingPageEvent event, Emitter<NewListingPageState> emit) async {
    if (state.hasReachedMax) {
      return;
    }

    try {
      final listings = await listingRepository.getListings(
        GetListingsRequest(filterData: state.filterData)
      );

      listings.isEmpty
        ? emit(state.copyWith(hasReachedMax: true))
        : emit(state.copyWith(
          status: ListingPageStatus.success,
          listings: List.of(state.listings)..addAll(listings),
          hasReachedMax: listings.isEmpty
        )
      );
    } catch (_) {
      emit(state.copyWith(status: ListingPageStatus.failure));
    }
  }
}
