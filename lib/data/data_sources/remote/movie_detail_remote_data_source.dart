import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../config.dart';
import '../../models/movie_credits.dart';
import '../../models/movie_detail.dart';
import '../../models/movie_list.dart';
import '../../models/movie_review.dart';
import '../../models/movie_video.dart';
import 'package:flutter/foundation.dart';

abstract class IMovieDetailRemoteDataSource {
  Future<MovieDetail> fetchMovieDetail({@required String movieId});
  Future<MovieReview> fetchMovieReview({@required String movieId});
  Future<MovieVideo> fetchMovieVideo({@required String movieId});
  Future<MovieCredit> fetchMovieCredit({@required String movieId});
  Future<MovieList> fetchMovieSimilar({@required String movieId});
}

class MovieDetailRemoteDataSource implements IMovieDetailRemoteDataSource {
  @override
  Future<MovieCredit> fetchMovieCredit({String movieId}) async {
    http.Response response =
        await http.get("$BASE_URL/movie/$movieId/credits/?api_key=$API_KEY");
    if (response.statusCode == 200) {
      return MovieCredit.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }

  @override
  Future<MovieDetail> fetchMovieDetail({String movieId}) async {
    http.Response response =
        await http.get("$BASE_URL/movie/$movieId?api_key=$API_KEY");
    if (response.statusCode == 200) {
      return MovieDetail.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }

  @override
  Future<MovieReview> fetchMovieReview({String movieId}) async {
    http.Response response =
        await http.get("$BASE_URL/movie/$movieId/reviews?api_key=$API_KEY");
    if (response.statusCode == 200) {
      return MovieReview.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }

  @override
  Future<MovieList> fetchMovieSimilar({String movieId}) async {
    http.Response response =
        await http.get("$BASE_URL/movie/$movieId/similar?api_key=$API_KEY");
    if (response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }

  @override
  Future<MovieVideo> fetchMovieVideo({String movieId}) {
    // TODO: implement fetchMovieVideo
    throw UnimplementedError();
  }

}