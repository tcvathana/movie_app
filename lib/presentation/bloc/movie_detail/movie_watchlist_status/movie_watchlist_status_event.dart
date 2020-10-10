part of 'movie_watchlist_status_bloc.dart';

abstract class MovieWatchlistStatusEvent extends Equatable {
  const MovieWatchlistStatusEvent();
}

class GetMovieWatchlistStatusEvent extends MovieWatchlistStatusEvent {
  final String sessionId;
  final int mediaId;

  GetMovieWatchlistStatusEvent({this.sessionId, this.mediaId});

  @override
  List<Object> get props => [sessionId, mediaId];
}

class AddToWatchlistEvent extends MovieWatchlistStatusEvent {
  final String sessionId;
  final int accountId;
  final int mediaId;
  final bool watchlist;

  AddToWatchlistEvent({
    this.sessionId,
    this.accountId,
    this.mediaId,
    this.watchlist,
  });

  @override
  List<Object> get props => [sessionId, accountId, mediaId, watchlist];
}
