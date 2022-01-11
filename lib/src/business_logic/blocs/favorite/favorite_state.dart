part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
}

class FavoriteInitialState extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteLoadingState extends FavoriteState {

  const FavoriteLoadingState();

  @override
  List<Object> get props => [];
}

class FavoriteLoadedState extends FavoriteState {

  final List<String> listingIds;

  const FavoriteLoadedState({
    required this.listingIds
  });

  @override
  List<Object?> get props => [ listingIds ];
}

class FavoriteAddingInProgressState extends FavoriteState {
  const FavoriteAddingInProgressState();

  @override
  List<Object?> get props => [];
}