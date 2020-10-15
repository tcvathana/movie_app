part of 'see_more_movie_bloc.dart';

abstract class SeeMoreMovieEvent extends Equatable {
  const SeeMoreMovieEvent();
}

class GetSeeMoreMovieEvent extends SeeMoreMovieEvent{
  final String movieType;

  GetSeeMoreMovieEvent(this.movieType);
  @override
  List<Object> get props => [];
}
