import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../config.dart';
import '../../models/movie_list.dart';
import '../../models/movie_account_states.dart';

abstract class IMovieRemoteDataSource {
  Future<MovieList> fetchNowPlayingMovieList();

  Future<MovieList> fetchMostPopularMovieList();

  Future<MovieList> fetchTopRatedMovieList();

  Future<MovieList> fetchUpComingMovieList();

  Future<MovieAccountStates> fetchMovieAccountStates({
    @required String sessionId,
    @required int movieId,
  });
}

class MovieRemoteDataSource implements IMovieRemoteDataSource {
  @override
  Future<MovieList> fetchMostPopularMovieList() async {
    return await _getMovieListFromUrl("/movie/popular");
  }

  @override
  Future<MovieList> fetchNowPlayingMovieList() async {
    return await _getMovieListFromUrl("/movie/now_playing");
  }

  @override
  Future<MovieList> fetchTopRatedMovieList() async {
    return await _getMovieListFromUrl("/movie/top_rated");
  }

  @override
  Future<MovieList> fetchUpComingMovieList() async {
    return await _getMovieListFromUrl("/movie/upcoming");
  }

  @override
  Future<MovieAccountStates> fetchMovieAccountStates({
    String sessionId,
    int movieId,
  }) async {
    http.Response response = await http.get(
        "$BASE_URL/movie/$movieId/account_states?api_key=$API_KEY&session_id=$sessionId");
    if (response.statusCode == 200) {
      return MovieAccountStates.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }

  Future<MovieList> _getMovieListFromUrl(String url) async {
    http.Response response =
    await http.get("$BASE_URL$url?api_key=$API_KEY");
    if (response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }
}
