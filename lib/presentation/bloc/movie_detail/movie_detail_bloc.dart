import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/data/models/movie_credits.dart';
import 'package:movie_app/data/models/movie_detail.dart';
import 'package:movie_app/data/models/movie_list.dart';
import 'package:movie_app/data/models/movie_review.dart';
import 'package:movie_app/data/models/movie_video.dart';
import 'package:movie_app/data/repositories/movie_detail_repository.dart';

part 'movie_detail_event.dart';

part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieDetailRepository movieDetailRepository;

  MovieDetailBloc({this.movieDetailRepository}) : super(MovieDetailInitial());

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event,) async* {
    if (event is GetMovieDetailEvent) {
      try {
        yield MovieDetailLoading();
        final movieDetail = await movieDetailRepository.getMovieDetail(
          movieId: event.movieId,
        );
        final movieReview = await movieDetailRepository.getMovieReview(
          movieId: event.movieId,
        );
        final movieVideo = await movieDetailRepository.getMovieVideo(
          movieId: event.movieId,
        );
        final movieCredit = await movieDetailRepository.getMovieCredit(
          movieId: event.movieId,
        );
        final movieSimilar = await movieDetailRepository.getMovieSimilar(
          movieId: event.movieId,
        );
        yield
        MovieDetailLoaded(
          movieDetail: movieDetail,
          movieReview: movieReview,
          movieVideo: movieVideo,
          movieCredit: movieCredit,
          movieSimilar: movieSimilar,
        );
      } catch (e) {
        yield MovieDetailError(e.message);
      }
    }
  }
}
