import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/movie_list.dart';
import 'package:movie_app/data/repositories/search_repository.dart';

part 'search_movie_event.dart';

part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchEvent, SearchMovieState> {
  final SearchRepository searchRepository;

  SearchMovieBloc({this.searchRepository}) : super(SearchMovieInitial());

  @override
  Stream<SearchMovieState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is GetSearchEvent) {
      try{
        yield SearchMovieLoading();
        final movieList = await searchRepository.getSearchMovie(
          query: event.query,
        );
        yield SearchMovieLoaded(movieList);
      } catch(e) {
        yield SearchMovieError(e.message);
      }
    }
  }
}
