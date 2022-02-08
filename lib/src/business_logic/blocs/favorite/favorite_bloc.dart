import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_instrument/src/data/repositories/favorite_repository.dart';

part 'favorite_state.dart';
part 'favorite_event.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;

  FavoriteBloc({
    required this.favoriteRepository
  }) : super(FavoriteInitialState()) {
    on<FavoriteEvent>((event, emit) async =>
     await _onFavoriteEvent(event, emit)
    );
  }

  Future<void> _onFavoriteEvent(FavoriteEvent event, Emitter<FavoriteState> emit) async {
    try {
      if (event is LoadFavoritesEvent) {
        emit(const FavoriteLoadingState());

        final List<String> listings = await favoriteRepository.getFavorites();

        emit(FavoriteLoadedState(listingIds: listings));
      } else if (event is FavoriteClickEvent) {
        await _manageFavoriteClickEvent(event, emit);
      } else if (event is ClearFavoritesEvent) {
        emit(FavoriteInitialState());
      }
    } catch (_) {
      emit(const FavoriteLoadedState(listingIds: []));
    }
  }

  Future<void> _manageFavoriteClickEvent(FavoriteClickEvent event, Emitter<FavoriteState> emit) async {
    if (state is FavoriteLoadedState) {
      if ((state as FavoriteLoadedState).listingIds.contains(event.listingId)) {
        await _manageFavoriteRemove(event, emit);
      } else {
        await _manageFavoriteAdd(event, emit);
      }
    }
  }

  Future<void> _manageFavoriteRemove(FavoriteClickEvent event, Emitter<FavoriteState> emit) async {
    try {
      emit(FavoriteLoadedState(listingIds:
        List.of((state as FavoriteLoadedState).listingIds)..remove(event.listingId)
      ));

      final favoriteRemove = await favoriteRepository.removeFavorite(event.listingId);

      if (!favoriteRemove) {
        throw Exception("Wasn't removed!");
      }
    } catch (_) {
      emit(FavoriteLoadedState(listingIds:
        List.of((state as FavoriteLoadedState).listingIds)..add(event.listingId)
      ));
    }
  }

  Future<void> _manageFavoriteAdd(FavoriteClickEvent event, Emitter<FavoriteState> emit) async {
    try {
      emit(FavoriteLoadedState(listingIds:
        List.of((state as FavoriteLoadedState).listingIds)..add(event.listingId)
      ));

      final favoriteAdd = await favoriteRepository.addFavorite(event.listingId);

      if (!favoriteAdd) {
        throw Exception("Wasn't added!");
      }
    } catch (_) {
      emit(FavoriteLoadedState(listingIds:
        List.of((state as FavoriteLoadedState).listingIds)..remove(event.listingId)
      ));
    }
  }
}
