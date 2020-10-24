import 'package:http/http.dart' as http;
import '../../../config.dart';
import '../../models/movie_list.dart';

abstract class IMovieRemoteDataSource {
  Future<MovieList> fetchNowPlayingMovieList();

  Future<MovieList> fetchMostPopularMovieList();

  Future<MovieList> fetchTopRatedMovieList();

  Future<MovieList> fetchUpComingMovieList();
}

class MovieRemoteDataSource implements IMovieRemoteDataSource {
  @override
  Future<MovieList> fetchMostPopularMovieList({int page = 1}) async {
    return await _getMovieListFromUrl("/movie/popular", page: page);
  }

  @override
  Future<MovieList> fetchNowPlayingMovieList({int page = 1}) async {
    return await _getMovieListFromUrl("/movie/now_playing", page: page);
  }

  @override
  Future<MovieList> fetchTopRatedMovieList({int page = 1}) async {
    return await _getMovieListFromUrl("/movie/top_rated", page: page);
  }

  @override
  Future<MovieList> fetchUpComingMovieList({int page = 1}) async {
    return await _getMovieListFromUrl("/movie/upcoming", page: page);
  }

  Future<MovieList> _getMovieListFromUrl(String url, {int page}) async {
    http.Response response = await http.get(
      "$BASE_URL$url?api_key=$API_KEY&page=$page",
    );
    if (response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }
}
