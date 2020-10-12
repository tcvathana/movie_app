import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/movie_list.dart';
import 'package:movie_app/data/repositories/search_repository.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;

  SearchBloc({this.searchRepository}) : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is GetSearchEvent) {
      try{
        yield SearchLoading();
        final movieList = await searchRepository.getSearchMovie(
          query: event.query,
        );
        yield SearchLoaded(movieList);
      } catch(e) {
        yield SearchError(e.message);
      }
    }
  }
}
