part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class HomePageError extends HomePageEvent {
  const HomePageError();

  @override
  List<Object> get props => [];
}

class HomePageLoaded extends HomePageEvent {
  const HomePageLoaded();

  @override
  List<Object> get props => [];
}

class HomePageReload extends HomePageEvent {
  const HomePageReload();

  @override
  List<Object> get props => [];
}