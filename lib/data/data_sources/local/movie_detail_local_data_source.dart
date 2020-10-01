import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../config.dart';
import '../../models/movie_credits.dart';
import '../../models/movie_detail.dart';
import '../../models/movie_list.dart';
import '../../models/movie_review.dart';
import '../../models/movie_video.dart';
import 'package:flutter/foundation.dart';

abstract class IMovieDetailLocalDataSource {
  Future<MovieDetail> getMovieDetail({@required String movieId});
  Future<MovieReview> getMovieReview({@required String movieId});
  Future<MovieVideo> getMovieVideo({@required String movieId});
  Future<MovieCredit> getMovieCredit({@required String movieId});
  Future<MovieList> getMovieSimilar({@required String movieId});
}

class MovieDetailLocalDataSource implements IMovieDetailLocalDataSource {
  @override
  Future<MovieCredit> getMovieCredit({@required String movieId}) {
    // TODO: implement getMovieCredit
    throw UnimplementedError();
  }

  @override
  Future<MovieDetail> getMovieDetail({@required String movieId}) {
    // TODO: implement getMovieDetail
    throw UnimplementedError();
  }

  @override
  Future<MovieReview> getMovieReview({@required String movieId}) {
    // TODO: implement getMovieReview
    throw UnimplementedError();
  }

  @override
  Future<MovieList> getMovieSimilar({@required String movieId}) {
    // TODO: implement getMovieSimilar
    throw UnimplementedError();
  }

  @override
  Future<MovieVideo> getMovieVideo({@required String movieId}) {
    // TODO: implement getMovieVideo
    throw UnimplementedError();
  }

}