part of 'favorite_movie_bloc.dart';

abstract class FavoriteMovieState extends Equatable {
  const FavoriteMovieState();
}

class FavoriteMovieInitial extends FavoriteMovieState {
  @override
  List<Object> get props => [];
}

class FavoriteMovieLoadingState extends FavoriteMovieState {
  @override
  List<Object> get props => [];
}

class FavoriteMovieLoadedState extends FavoriteMovieState {
  final MovieList movieList;

  FavoriteMovieLoadedState(this.movieList);

  @override
  List<Object> get props => [movieList];
}

class FavoriteMovieErrorState extends FavoriteMovieState {
  final String error;

  FavoriteMovieErrorState(this.error);

  @override
  List<Object> get props => [error];
}
