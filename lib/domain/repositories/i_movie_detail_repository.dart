import 'package:meta/meta.dart';
import 'package:movie_app/data/models/movie_account_states.dart';
import 'package:movie_app/data/models/movie_credits.dart';
import 'package:movie_app/data/models/movie_detail.dart';
import 'package:movie_app/data/models/movie_list.dart';
import 'package:movie_app/data/models/movie_review.dart';
import 'package:movie_app/data/models/movie_video.dart';

abstract class IMovieDetailRepository {
  Future<MovieDetail> getMovieDetail ({@required int movieId});
  Future<MovieReview> getMovieReview ({@required int movieId});
  Future<MovieVideo> getMovieVideo ({@required int movieId});
  Future<MovieCredit> getMovieCredit ({@required int movieId});
  Future<MovieList> getMovieSimilar ({@required int movieId});
  //
  Future<MovieAccountStates> getMovieAccountStates({
    @required String sessionId,
    @required int movieId,
  });
}