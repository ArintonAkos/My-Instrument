import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_instrument/src/data/models/responses/main/listing/listing_model.dart';
import 'package:my_instrument/src/data/repositories/listing_repository.dart';

part 'listing_page_event.dart';
part 'listing_page_state.dart';

class ListingPageBloc extends Bloc<ListingPageEvent, ListingPageState> {
  final ListingRepository listingRepository;

  ListingPageBloc({
    required this.listingRepository
  }) : super(ListingPageState.initial()) {
    on<ListingPageEvent>(_handleEvent);
  }

  _handleEvent(ListingPageEvent event, Emitter<ListingPageState> emit) async {
    if (event is LoadListingEvent) {
      emit(state.copyWith(status: ListingPageStatus.loading));

      try {
        var listing = await listingRepository.getListing(event.listingId);

        emit(state.copyWith(
          status: ListingPageStatus.success,
          listing: listing
        ));
      } catch (e) {
        emit(state.copyWith(status: ListingPageStatus.failure));
      }
    }
  }
}
