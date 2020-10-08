part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();
}

class WatchlistMovieInitial extends WatchlistMovieState {
  @override
  List<Object> get props => [];
}

class WatchlistMovieLoadingState extends WatchlistMovieState {
  @override
  List<Object> get props => [];
}

class WatchlistMovieLoadedState extends WatchlistMovieState {
  final MovieList movieList;

  WatchlistMovieLoadedState(this.movieList);

  @override
  List<Object> get props => [movieList];
}

class WatchlistMovieErrorState extends WatchlistMovieState{
  final String error;

  WatchlistMovieErrorState(this.error);
  @override
  List<Object> get props => [error];

}
