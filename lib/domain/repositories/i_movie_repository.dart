import 'package:meta/meta.dart';
import '../../data/models/movie_list.dart';
import '../../data/models/movie_account_states.dart';

abstract class IMovieRepository {
  Future<MovieList> getNowPlayingMovieList();

  Future<MovieList> getMostPopularMovieList();

  Future<MovieList> getTopRatedMovieList();

  Future<MovieList> getUpComingMovieList();

  //
  Future<MovieAccountStates> getMovieAccountStates({
    @required String sessionId,
    @required int movieId,
  });
}
