import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/movie_list.dart';
import 'package:movie_app/data/repositories/movie_repository.dart';

part 'movie_list_event.dart';

part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieRepository movieRepository;

  MovieListBloc({this.movieRepository}) : super(MovieListInitial());

  @override
  Stream<MovieListState> mapEventToState(
    MovieListEvent event,
  ) async* {
    if (event is GetMovieListEvent) {
      try {
        yield MovieListLoading();
        final MovieList nowPlayingMovie =
        await movieRepository.getNowPlayingMovieList();
        final MovieList popularMovie =
        await movieRepository.getMostPopularMovieList();
        final MovieList topRatedMovie =
        await movieRepository.getTopRatedMovieList();
        final MovieList upComingMovie =
        await movieRepository.getUpComingMovieList();
        yield MovieListLoaded(
          nowPlayingMovie: nowPlayingMovie,
          popularMovie: popularMovie,
          topRatedMovie: topRatedMovie,
          upComingMovie: upComingMovie,
        );
      } catch(e) {
        yield MovieListError(e.message);
      }
    }
  }
}
