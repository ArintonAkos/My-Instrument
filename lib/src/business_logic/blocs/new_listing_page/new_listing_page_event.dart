part of 'new_listing_page_bloc.dart';

abstract class NewListingPageEvent extends Equatable {
  const NewListingPageEvent();
}

class GetCategoriesEvent extends NewListingPageEvent {

  const GetCategoriesEvent();

  @override
  List<Object> get props => [];
}

class CreateListingEvent extends NewListingPageEvent {

  const CreateListingEvent();

  @override
  List<Object> get props => [];
}