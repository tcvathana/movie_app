import '../../data/models/movie_list.dart';

abstract class IMovieRepository {
  Future<MovieList> getNowPlayingMovieList();

  Future<MovieList> getMostPopularMovieList();

  Future<MovieList> getTopRatedMovieList();

  Future<MovieList> getUpComingMovieList();

}
