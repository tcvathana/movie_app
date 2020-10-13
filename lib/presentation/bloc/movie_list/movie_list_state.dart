part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();
}

class MovieListInitial extends MovieListState {
  @override
  List<Object> get props => [];
}

class MovieListLoading extends MovieListState {
  @override
  List<Object> get props => [];
}

class MovieListLoaded extends MovieListState {
  final MovieList nowPlayingMovie;
  final MovieList popularMovie;
  final MovieList topRatedMovie;
  final MovieList upComingMovie;

  MovieListLoaded({
    this.nowPlayingMovie,
    this.popularMovie,
    this.topRatedMovie,
    this.upComingMovie,
  });

  @override
  List<Object> get props => [
        nowPlayingMovie,
        popularMovie,
        topRatedMovie,
        upComingMovie,
      ];
}

class MovieListError extends MovieListState {
  final String error;

  MovieListError(this.error);

  @override
  List<Object> get props => [error];
}
