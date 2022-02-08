
part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoritesEvent extends FavoriteEvent {
  const LoadFavoritesEvent();

  @override
  List<Object> get props => [];
}

class FavoriteClickEvent extends FavoriteEvent {
  final String listingId;

  const FavoriteClickEvent({
    required this.listingId
  });

  @override
  List<Object> get props => [ listingId ];
}

class ClearFavoritesEvent extends FavoriteEvent {

  const ClearFavoritesEvent();

  @override
  List<Object> get props => [];
}