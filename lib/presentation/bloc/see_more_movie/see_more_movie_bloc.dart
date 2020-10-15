import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'see_more_movie_event.dart';
part 'see_more_movie_state.dart';

class SeeMoreMovieBloc extends Bloc<SeeMoreMovieEvent, SeeMoreMovieState> {
  SeeMoreMovieBloc() : super(SeeMoreMovieInitial());

  @override
  Stream<SeeMoreMovieState> mapEventToState(
    SeeMoreMovieEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
