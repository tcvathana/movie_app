import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/movie_list.dart';
import 'package:movie_app/data/repositories/account_repository.dart';

part 'favorite_movie_event.dart';

part 'favorite_movie_state.dart';

class FavoriteMovieBloc extends Bloc<FavoriteMovieEvent, FavoriteMovieState> {
  final AccountRepository accountRepository;

  FavoriteMovieBloc({this.accountRepository}) : super(FavoriteMovieInitial());

  @override
  Stream<FavoriteMovieState> mapEventToState(
    FavoriteMovieEvent event,
  ) async* {
    if (event is GetFavoriteMovieEvent) {
      try{
        yield FavoriteMovieLoadingState();
        final favoriteMovie = await accountRepository.getFavoriteMovieList(
          sessionId: event.sessionId,
          accountId: event.accountId,
        );
        yield FavoriteMovieLoadedState(favoriteMovie);
      } catch(e) {
        yield FavoriteMovieErrorState(e.message);
      }
    }
  }
}
