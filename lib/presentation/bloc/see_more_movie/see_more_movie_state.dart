part of 'see_more_movie_bloc.dart';

abstract class SeeMoreMovieState extends Equatable {
  const SeeMoreMovieState();
}

class SeeMoreMovieInitial extends SeeMoreMovieState {
  @override
  List<Object> get props => [];
}

class SeeMoreMovieLoading extends SeeMoreMovieState {
  @override
  List<Object> get props => [];
}
class SeeMoreMovieLoaded extends SeeMoreMovieState {
  final List<ResultMovie> movieList;

  SeeMoreMovieLoaded(this.movieList);

  @override
  List<Object> get props => [movieList];
}

class SeeMoreMovieError extends SeeMoreMovieState{
  final String error;

  SeeMoreMovieError(this.error);

  @override
  List<Object> get props => [error];
}
