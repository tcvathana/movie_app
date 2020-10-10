import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/repositories/account_repository.dart';
import 'package:movie_app/data/repositories/movie_detail_repository.dart';

part 'movie_watchlist_status_event.dart';

part 'movie_watchlist_status_state.dart';

class MovieWatchlistStatusBloc
    extends Bloc<MovieWatchlistStatusEvent, MovieWatchlistStatusState> {
  final AccountRepository accountRepository;
  final MovieDetailRepository movieDetailRepository;

  MovieWatchlistStatusBloc({
    this.accountRepository,
    this.movieDetailRepository,
  }) : super(MovieWatchlistStatusInitial());

  @override
  Stream<MovieWatchlistStatusState> mapEventToState(
    MovieWatchlistStatusEvent event,
  ) async* {
    if(event is AddToWatchlistEvent) {
      try{
        yield MovieWatchlistStatusLoading();
        await accountRepository.addToWatchlist(
          sessionId: event.sessionId,
          accountId: event.accountId,
          mediaId: event.mediaId,
          watchlist: event.watchlist,
        );
        final movieAccState = await movieDetailRepository.getMovieAccountStates(
          sessionId: event.sessionId,
          movieId: event.mediaId,
        );
        yield MovieWatchlistStatusLoaded(movieAccState.watchlist);
      } catch(e){
        yield MovieWatchlistStatusError("Something went wrong");
      }
    }
    if(event is GetMovieWatchlistStatusEvent) {
      try{
        yield MovieWatchlistStatusLoading();
        final movieAccState = await movieDetailRepository.getMovieAccountStates(
          sessionId: event.sessionId,
          movieId: event.mediaId,
        );
        yield MovieWatchlistStatusLoaded(movieAccState.watchlist);
      } catch(e){
        yield MovieWatchlistStatusError("Something went wrong");
      }
    }
  }
}
