part of 'favorite_movie_bloc.dart';

abstract class FavoriteMovieEvent extends Equatable {
  const FavoriteMovieEvent();
}

class GetFavoriteMovieEvent extends FavoriteMovieEvent {
  final String sessionId;
  final String accountId;

  GetFavoriteMovieEvent({this.sessionId, this.accountId});

  @override
  List<Object> get props => [sessionId, accountId];
}
