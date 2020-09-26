import 'package:meta/meta.dart';
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
  Future<MovieList> fetchMostPopularMovieList() {
    // TODO: implement fetchMostPopularMovieList
    throw UnimplementedError();
  }

  @override
  Future<MovieAccountStates> fetchMovieAccountStates({String sessionId, int movieId}) {
    // TODO: implement fetchMovieAccountStates
    throw UnimplementedError();
  }

  @override
  Future<MovieList> fetchNowPlayingMovieList() {
    // TODO: implement fetchNowPlayingMovieList
    throw UnimplementedError();
  }

  @override
  Future<MovieList> fetchTopRatedMovieList() {
    // TODO: implement fetchTopRatedMovieList
    throw UnimplementedError();
  }

  @override
  Future<MovieList> fetchUpComingMovieList() {
    // TODO: implement fetchUpComingMovieList
    throw UnimplementedError();
  }

}