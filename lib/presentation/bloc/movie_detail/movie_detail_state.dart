part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
}

class MovieDetailInitial extends MovieDetailState {
  @override
  List<Object> get props => [];
}

class MovieDetailLoading extends MovieDetailState {
  @override
  List<Object> get props => [];
}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;

  MovieDetailLoaded(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class MovieDetailError extends MovieDetailState {
  final String error;

  MovieDetailError(this.error);

  @override
  List<Object> get props => [error];
}
