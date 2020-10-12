part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class GetSearchEvent extends SearchEvent {
  final String query;

  GetSearchEvent(this.query);

  @override
  List<Object> get props => [query];
}
