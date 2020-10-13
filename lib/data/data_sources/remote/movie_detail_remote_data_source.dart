import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../../../config.dart';
import '../../models/movie_account_states.dart';
import '../../models/movie_credits.dart';
import '../../models/movie_detail.dart';
import '../../models/movie_list.dart';
import '../../models/movie_review.dart';
import '../../models/movie_video.dart';

abstract class IMovieDetailRemoteDataSource {
  Future<MovieDetail> fetchMovieDetail({@required int movieId});
  Future<MovieReview> fetchMovieReview({@required int movieId});
  Future<MovieVideo> fetchMovieVideo({@required int movieId});
  Future<MovieCredit> fetchMovieCredit({@required int movieId});
  Future<MovieList> fetchMovieSimilar({@required int movieId});
  Future<MovieAccountStates> fetchMovieAccountStates({
    @required String sessionId,
    @required int movieId,
  });
}

class MovieDetailRemoteDataSource implements IMovieDetailRemoteDataSource {
  @override
  Future<MovieCredit> fetchMovieCredit({@required int movieId}) async {
    http.Response response =
        await http.get("$BASE_URL/movie/$movieId/credits?api_key=$API_KEY");
    if (response.statusCode == 200) {
      return MovieCredit.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }

  @override
  Future<MovieDetail> fetchMovieDetail({int movieId}) async {
    http.Response response =
        await http.get("$BASE_URL/movie/$movieId?api_key=$API_KEY");
    final responseMap = json.decode(response.body);
    if (response.statusCode == 200) {
      return MovieDetail.fromJson(response.body);
    } else {
      final String statusMessage = responseMap["status_message"];
      throw Exception(statusMessage);
    }
  }

  @override
  Future<MovieReview> fetchMovieReview({int movieId}) async {
    http.Response response =
        await http.get("$BASE_URL/movie/$movieId/reviews?api_key=$API_KEY");
    if (response.statusCode == 200) {
      return MovieReview.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }

  @override
  Future<MovieList> fetchMovieSimilar({int movieId}) async {
    http.Response response =
        await http.get("$BASE_URL/movie/$movieId/similar?api_key=$API_KEY");
    if (response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }

  @override
  Future<MovieVideo> fetchMovieVideo({int movieId}) async {
    http.Response response =
        await http.get("$BASE_URL/movie/$movieId/videos?api_key=$API_KEY");
    if (response.statusCode == 200) {
      return MovieVideo.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }

  @override
  Future<MovieAccountStates> fetchMovieAccountStates({
    String sessionId,
    int movieId,
  }) async {
    http.Response response = await http.get(
        "$BASE_URL/movie/$movieId/account_states?api_key=$API_KEY&session_id=$sessionId");
    final responseMap = json.decode(response.body);
    if (response.statusCode == 200) {
      return MovieAccountStates.fromJson(response.body);
    } else {
      final String statusMessage = responseMap["status_message"];
      throw Exception(statusMessage);
    }
  }
}