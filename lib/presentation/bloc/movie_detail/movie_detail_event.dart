part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class GetMovieDetailEvent extends MovieDetailEvent {
  final int movieId;

  GetMovieDetailEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}
