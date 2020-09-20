import 'package:meta/meta.dart';
import '../../data/models/movie_list.dart';
import '../../data/models/movie_account_states.dart';

abstract class IMovieRepository {
  Future<MovieList> fetchNowPlayingMovieList();

  Future<MovieList> fetchMostPopularMovieList();

  Future<MovieList> fetchTopRatedMovieList();

  Future<MovieList> fetchUpComingMovieList();

  //
  Future<MovieAccountStates> fetchMovieAccountStates({
    @required String sessionId,
    @required int movieId,
  });
}
