import 'dart:async';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/data/models/movie_account_states.dart';
import '../../domain/repositories/i_movie_repository.dart';
import '../../config.dart';
import '../models/movie_list.dart';

class MovieRepository implements IMovieRepository {
  @override
  Future<MovieList> getNowPlayingMovieList() async {
    http.Response response =
        await http.get("$SERVICE_URL/movie/now_playing?api_key=$API_KEY");
    if (response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }

  @override
  Future<MovieList> getMostPopularMovieList() async {
    http.Response response =
        await http.get("$SERVICE_URL/movie/popular?api_key=$API_KEY");
    if (response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }

  @override
  Future<MovieList> getTopRatedMovieList() async {
    http.Response response =
        await http.get("$SERVICE_URL/movie/top_rated?api_key=$API_KEY");
    if (response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }

  @override
  Future<MovieList> getUpComingMovieList() async {
    http.Response response =
        await http.get("$SERVICE_URL/movie/upcoming?api_key=$API_KEY");
    if (response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }

  //
  @override
  Future<MovieAccountStates> getMovieAccountStates({
    @required String sessionId,
    @required int movieId,
  }) async {
    http.Response response = await http.get(
        "$SERVICE_URL/movie/$movieId/account_states?api_key=$API_KEY&session_id=$sessionId");
    if (response.statusCode == 200) {
      return MovieAccountStates.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }
}
