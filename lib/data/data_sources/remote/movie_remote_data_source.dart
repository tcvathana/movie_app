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

  Future<MovieList> _getMovieListFromUrl(String url) async {
    http.Response response = await http.get("$BASE_URL$url?api_key=$API_KEY");
    if (response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }
}
