part of 'movie_list_bloc.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();
}

class GetMovieListEvent extends MovieListEvent {
  @override
  List<Object> get props => [];
}
