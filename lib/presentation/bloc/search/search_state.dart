part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoaded extends SearchState {
  final MovieList movieList;

  SearchLoaded(this.movieList);

  @override
  List<Object> get props => [movieList];
}

class SearchError extends SearchState {
  final String error;

  SearchError(this.error);

  @override
  List<Object> get props => [error];
}