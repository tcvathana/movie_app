import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/movie_credits.dart';
import '../../models/movie_detail.dart';
import '../../models/movie_list.dart';
import '../../models/movie_review.dart';
import '../../models/movie_video.dart';
import 'package:flutter/foundation.dart';

abstract class IMovieDetailLocalDataSource {
  Future<MovieDetail> getMovieDetail({@required int movieId});

  Future<MovieReview> getMovieReview({@required int movieId});

  Future<MovieVideo> getMovieVideo({@required int movieId});

  Future<MovieCredit> getMovieCredit({@required int movieId});

  Future<MovieList> getMovieSimilar({@required int movieId});

  Future<void> cacheMovieDetail(
      {@required int movieId, MovieDetail movieDetail});

  Future<void> cacheMovieReview(
      {@required int movieId, MovieReview movieReview});

  Future<void> cacheMovieVideo(
      {@required int movieId, MovieVideo movieVideo});

  Future<void> cacheMovieCredit(
      {@required int movieId, MovieCredit movieCredit});

  Future<void> cacheMovieSimilar(
      {@required int movieId, MovieList movieList});
}

class MovieDetailLocalDataSource implements IMovieDetailLocalDataSource {
  final SharedPreferences sharedPreferences;

  MovieDetailLocalDataSource({@required this.sharedPreferences});

  @override
  Future<MovieCredit> getMovieCredit({@required int movieId}) {
    final String jsonString = sharedPreferences.getString("/movie/$movieId/credits");
    if (jsonString != null) {
      return Future.value(MovieCredit.fromJson(jsonString));
    } else {
      throw Exception("Cache error");
    }
  }

  @override
  Future<MovieDetail> getMovieDetail({@required int movieId}) {
    final String jsonString = sharedPreferences.getString("/movie/$movieId");
    if (jsonString != null) {
      return Future.value(MovieDetail.fromJson(jsonString));
    } else {
      throw Exception("Cache error");
    }
  }

  @override
  Future<MovieReview> getMovieReview({@required int movieId}) {
    final String jsonString = sharedPreferences.getString("/movie/$movieId/reviews");
    if (jsonString != null) {
      return Future.value(MovieReview.fromJson(jsonString));
    } else {
      throw Exception("Cache error");
    }
  }

  @override
  Future<MovieList> getMovieSimilar({@required int movieId}) {
    final String jsonString = sharedPreferences.getString("/movie/$movieId/similar");
    if (jsonString != null) {
      return Future.value(MovieList.fromJson(jsonString));
    } else {
      throw Exception("Cache error");
    }
  }

  @override
  Future<MovieVideo> getMovieVideo({@required int movieId}) {
    final String jsonString = sharedPreferences.getString("/movie/$movieId/videos");
    if (jsonString != null) {
      return Future.value(MovieVideo.fromJson(jsonString));
    } else {
      throw Exception("Cache error");
    }
  }

  // CACHE METHOD
  @override
  Future<void> cacheMovieCredit({int movieId, MovieCredit movieCredit}) {
    return sharedPreferences.setString(
      "/movie/$movieId/credits",
      movieCredit.toJson(),
    );
  }

  @override
  Future<void> cacheMovieDetail({int movieId, MovieDetail movieDetail}) {
    return sharedPreferences.setString(
      "/movie/$movieId",
      movieDetail.toJson(),
    );
  }

  @override
  Future<void> cacheMovieReview({int movieId, MovieReview movieReview}) {
    return sharedPreferences.setString(
      "/movie/$movieId/reviews",
      movieReview.toJson(),
    );
  }

  @override
  Future<void> cacheMovieSimilar({int movieId, MovieList movieList}) {
    return sharedPreferences.setString(
      "/movie/$movieId/similar",
      movieList.toJson(),
    );
  }

  @override
  Future<void> cacheMovieVideo({int movieId, MovieVideo movieVideo}) {
    return sharedPreferences.setString(
      "/movie/$movieId/videos",
      movieVideo.toJson(),
    );
  }
}
