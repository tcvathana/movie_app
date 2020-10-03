import 'package:meta/meta.dart';
import 'package:movie_app/data/models/movie_account_states.dart';
import 'package:movie_app/data/models/movie_credits.dart';
import 'package:movie_app/data/models/movie_detail.dart';
import 'package:movie_app/data/models/movie_list.dart';
import 'package:movie_app/data/models/movie_review.dart';
import 'package:movie_app/data/models/movie_video.dart';

abstract class IMovieDetailRepository {
  Future<MovieDetail> getMovieDetail ({@required String movieId});
  Future<MovieReview> getMovieReview ({@required String movieId});
  Future<MovieVideo> getMovieVideo ({@required String movieId});
  Future<MovieCredit> getMovieCredit ({@required String movieId});
  Future<MovieList> getMovieSimilar ({@required String movieId});
  //
  Future<MovieAccountStates> getMovieAccountStates({
    @required String sessionId,
    @required int movieId,
  });
}