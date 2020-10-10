part of 'movie_watchlist_status_bloc.dart';

abstract class MovieWatchlistStatusState extends Equatable {
  const MovieWatchlistStatusState();
}

class MovieWatchlistStatusInitial extends MovieWatchlistStatusState {
  @override
  List<Object> get props => [];
}

class MovieWatchlistStatusLoading extends MovieWatchlistStatusState {
  @override
  List<Object> get props => [];
}

class MovieWatchlistStatusLoaded extends MovieWatchlistStatusState {
  final bool isWatchlist;

  MovieWatchlistStatusLoaded(this.isWatchlist);

  @override
  List<Object> get props => [isWatchlist];
}

class MovieWatchlistStatusError extends MovieWatchlistStatusState {
  final String error;

  MovieWatchlistStatusError(this.error);

  @override
  List<Object> get props => [error];
}
