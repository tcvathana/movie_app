import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/util/movie_type.dart';
import 'package:movie_app/data/data_sources/remote/movie_remote_data_source.dart';
import 'package:movie_app/data/models/movie_list.dart';

part 'see_more_movie_event.dart';

part 'see_more_movie_state.dart';

class SeeMoreMovieBloc extends Bloc<SeeMoreMovieEvent, SeeMoreMovieState> {
  final MovieRemoteDataSource remoteDataSource;

  SeeMoreMovieBloc({this.remoteDataSource}) : super(SeeMoreMovieInitial());

  @override
  Stream<SeeMoreMovieState> mapEventToState(
    SeeMoreMovieEvent event,
  ) async* {
    if (event is GetSeeMoreMovieEvent) {
      if (event.movieType == MovieType.popular) {
        yield SeeMoreMovieLoading();
        final movieList =
            await remoteDataSource.fetchMostPopularMovieList(page: 2);
        yield SeeMoreMovieLoaded(movieList.results);
      }
    }
  }
}
