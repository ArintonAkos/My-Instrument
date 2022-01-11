import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_instrument/bloc/main/product_list/filter_data.dart';
import 'package:my_instrument/src/data/models/requests/main/listing/get_listings_request.dart';
import 'package:my_instrument/src/data/models/responses/main/listing/listing_model.dart';
import 'package:my_instrument/src/data/repositories/listing_repository.dart';

part 'listing_page_event.dart';
part 'listing_page_state.dart';

class ListingPageBloc extends Bloc<ListingPageEvent, ListingPageState> {
  final ListingRepository _listingRepository = ListingRepository();

  ListingPageBloc() : super(ListingPageState()) {
    on<ListingPageEvent>(_onListingPageEvent);
  }

  Future<void> _onListingPageEvent(ListingPageEvent event, Emitter<ListingPageState> emit) async {
    if (state.hasReachedMax) {
      return;
    }

    try {
      final listings = await _listingRepository.getListings(
        GetListingsRequest(filterData: state.filterData)
      );

      listings.isEmpty
        ? emit(state.copyWith(hasReachedMax: true))
        : emit(state.copyWith(
            status: ListingPageStatus.success,
            listings: List.of(state.listings)..addAll(listings),
            hasReachedMax: listings.isEmpty
          ));

    } catch (_) {
      emit(state.copyWith(status: ListingPageStatus.failure));
    }
  }
}
