import 'dart:async';
import 'package:http/http.dart' as http;
import '../../domain/repositories/i_movie_repository.dart';
import '../../config.dart';
import '../models/movie_list.dart';

class MovieRepository implements IMovieRepository{
  @override
  Future<MovieList> fetchNowPlayingMovieList() async {
    http.Response response =
        await http.get("$SERVICE_URL/movie/now_playing?api_key=$API_KEY");
    if (response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }

  @override
  Future<MovieList> fetchMostPopularMovieList() async {
    http.Response response =
        await http.get("$SERVICE_URL/movie/popular?api_key=$API_KEY");
    if(response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }

  @override
  Future<MovieList> fetchTopRatedMovieList() async {
    http.Response response =
        await http.get("$SERVICE_URL/movie/top_rated?api_key=$API_KEY");
    if(response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }

  @override
  Future<MovieList> fetchUpComingMovieList() async {
    http.Response response =
        await http.get("$SERVICE_URL/movie/upcoming?api_key=$API_KEY");
    if(response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }
}
