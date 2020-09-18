import '../../data/models/movie_list.dart';
abstract class IMovieRepository {
  Future<MovieList> fetchNowPlayingMovieList();
  Future<MovieList> fetchMostPopularMovieList();
  Future<MovieList> fetchTopRatedMovieList();
  Future<MovieList> fetchUpComingMovieList();
}