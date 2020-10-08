import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/movie_list.dart';
import 'package:movie_app/data/repositories/account_repository.dart';

part 'watchlist_movie_event.dart';

part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final AccountRepository accountRepository;

  WatchlistMovieBloc({this.accountRepository}) : super(WatchlistMovieInitial());

  @override
  Stream<WatchlistMovieState> mapEventToState(
    WatchlistMovieEvent event,
  ) async* {
    if (event is GetWatchlistMovieEvent) {
      try {
        yield WatchlistMovieLoadingState();
        final MovieList movieList =
            await accountRepository.getWatchlistMovieList(
          sessionId: event.sessionId,
          accountId: event.accountId,
        );
        yield WatchlistMovieLoadedState(movieList);
      } catch (e) {
        yield WatchlistMovieErrorState(e.message);
      }
    }
  }
}
