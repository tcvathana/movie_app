part of 'search_movie_bloc.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();
}

class SearchMovieInitial extends SearchMovieState {
  @override
  List<Object> get props => [];
}

class SearchMovieLoading extends SearchMovieState {
  @override
  List<Object> get props => [];
}

class SearchMovieLoaded extends SearchMovieState {
  final MovieList movieList;

  SearchMovieLoaded(this.movieList);

  @override
  List<Object> get props => [movieList];
}

class SearchMovieError extends SearchMovieState {
  final String error;

  SearchMovieError(this.error);

  @override
  List<Object> get props => [error];
}