part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();
}

class GetWatchlistMovieEvent extends WatchlistMovieEvent {
  final String sessionId;
  final String accountId;

  GetWatchlistMovieEvent({this.sessionId, this.accountId});

  @override
  List<Object> get props => [sessionId, accountId];
}
