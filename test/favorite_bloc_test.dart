import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_instrument/src/business_logic/blocs/favorite/favorite_bloc.dart';
import 'package:my_instrument/src/data/repositories/favorite_repository.dart';

import 'favorite_bloc_test.mocks.dart';

@GenerateMocks([FavoriteRepository])
void main() {
  MockFavoriteRepository mockFavoriteRepository = MockFavoriteRepository();

  setUp(() {
  });

  group('GetFavorites', () {
    List<String> favorites = [];

    blocTest<FavoriteBloc, FavoriteState>(
      'emits [FavoriteLoadingState, FavoriteLoadedState] when successful',
      build: () {
        when(mockFavoriteRepository.getFavorites())
          .thenAnswer((_) async => favorites);
        return FavoriteBloc(favoriteRepository: mockFavoriteRepository)
            ..add(const LoadFavoritesEvent());
      },
      // listingId -> egy olyan id ami nem letezik
      act: (bloc) => bloc.add(const FavoriteClickEvent(listingId: '-')),
      expect: () => const <FavoriteState>[
        FavoriteLoadingState(),
        FavoriteLoadedState(listingIds: []),
        FavoriteLoadedState(listingIds: ['-']),
        FavoriteLoadedState(listingIds: [])
      ]
    );
  });
}