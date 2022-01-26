import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_instrument/src/business_logic/blocs/category/category_bloc.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageState.initial()) {
    on<HomePageEvent>(handleEvent);
  }

  FutureOr<void> handleEvent(HomePageEvent event, Emitter<HomePageState> emit) {
    if (event is HomePageError) {
      emit(state.copyWith(status: HomePageStatus.failure));
    } else if (event is HomePageLoaded) {
      emit(state.copyWith(status: HomePageStatus.success));
    } else if (event is HomePageReload) {
      emit(state.copyWith(status: HomePageStatus.reloading));
    }
  }
}
