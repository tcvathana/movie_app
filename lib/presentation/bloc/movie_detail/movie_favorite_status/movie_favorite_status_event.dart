part of 'movie_favorite_status_bloc.dart';

abstract class MovieFavoriteStatusEvent extends Equatable {
  const MovieFavoriteStatusEvent();
}

class GetMovieFavoriteStatusEvent extends MovieFavoriteStatusEvent {
  final String sessionId;
  final int mediaId;

  GetMovieFavoriteStatusEvent({this.sessionId, this.mediaId});

  @override
  List<Object> get props => [sessionId, mediaId];
}

class MarkAsFavoriteEvent extends MovieFavoriteStatusEvent {
  final String sessionId;
  final int accountId;
  final int mediaId;
  final bool favorite;

  MarkAsFavoriteEvent({
    this.sessionId,
    this.accountId,
    this.mediaId,
    this.favorite,
  });

  @override
  List<Object> get props => [sessionId, accountId, mediaId, favorite];
}
