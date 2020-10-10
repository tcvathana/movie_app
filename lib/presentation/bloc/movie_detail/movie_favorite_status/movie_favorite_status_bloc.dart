import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/repositories/account_repository.dart';
import 'package:movie_app/data/repositories/movie_detail_repository.dart';

part 'movie_favorite_status_event.dart';

part 'movie_favorite_status_state.dart';

class MovieFavoriteStatusBloc
    extends Bloc<MovieFavoriteStatusEvent, MovieFavoriteStatusState> {
  final AccountRepository accountRepository;
  final MovieDetailRepository movieDetailRepository;

  MovieFavoriteStatusBloc({
    this.movieDetailRepository,
    this.accountRepository,
  }) : super(MovieFavoriteStatusInitial());

  @override
  Stream<MovieFavoriteStatusState> mapEventToState(
    MovieFavoriteStatusEvent event,
  ) async* {
    if (event is MarkAsFavoriteEvent) {
      try {
        yield MovieFavoriteStatusLoading();
        await accountRepository.markAsFavorite(
          sessionId: event.sessionId,
          accountId: event.accountId,
          mediaId: event.mediaId,
          favorite: event.favorite,
        );
        final movieAccState = await movieDetailRepository.getMovieAccountStates(
          sessionId: event.sessionId,
          movieId: event.mediaId,
        );
        yield MovieFavoriteStatusLoaded(movieAccState.favorite);
      } catch(e) {
        yield MovieFavoriteStatusError(e.toString());
      }
    }
    if (event is GetMovieFavoriteStatusEvent) {
      try {
        yield MovieFavoriteStatusLoading();
        final movieAccState = await movieDetailRepository.getMovieAccountStates(
          sessionId: event.sessionId,
          movieId: event.mediaId,
        );
        yield MovieFavoriteStatusLoaded(movieAccState.favorite);
      } catch (e) {
        yield MovieFavoriteStatusError(e.message);
      }
    }
  }
}
