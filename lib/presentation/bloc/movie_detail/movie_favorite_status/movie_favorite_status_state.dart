part of 'movie_favorite_status_bloc.dart';

abstract class MovieFavoriteStatusState extends Equatable {
  const MovieFavoriteStatusState();
}

class MovieFavoriteStatusInitial extends MovieFavoriteStatusState {
  @override
  List<Object> get props => [];
}

class MovieFavoriteStatusLoading extends MovieFavoriteStatusState {
  @override
  List<Object> get props => [];
}

class MovieFavoriteStatusLoaded extends MovieFavoriteStatusState {
  final bool isFavorite;

  MovieFavoriteStatusLoaded(this.isFavorite);

  @override
  List<Object> get props => [isFavorite];
}

class MovieFavoriteStatusError extends MovieFavoriteStatusState {
  final String error;

  MovieFavoriteStatusError(this.error);

  @override
  List<Object> get props => [error];
}
