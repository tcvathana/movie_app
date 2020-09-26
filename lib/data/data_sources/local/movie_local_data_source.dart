import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/movie_account_states.dart';
import '../../models/movie_list.dart';

abstract class IMovieLocalDataSource {
  Future<MovieList> getLastNowPlayingMovieList();

  Future<MovieList> getLastMostPopularMovieList();

  Future<MovieList> getLastTopRatedMovieList();

  Future<MovieList> getLastUpComingMovieList();

  Future<MovieAccountStates> getLastMovieAccountStates({
    @required String sessionId,
    @required int movieId,
  });

  Future<void> cacheMovieList(String listType, MovieList movieList);
}

class MovieLocalDataSource implements IMovieLocalDataSource {
  final SharedPreferences sharedPreferences;

  MovieLocalDataSource({@required this.sharedPreferences});

  @override
  Future<MovieList> getLastNowPlayingMovieList() {
    final String jsonString = sharedPreferences.getString('now_playing');
    if (jsonString != null) {
      return Future.value(MovieList.fromJson(jsonString));
    } else {
      throw Exception("Error");
    }
  }

  @override
  Future<MovieList> getLastMostPopularMovieList() {
    // TODO: implement getLastMostPopularMovieList
    throw UnimplementedError();
  }

  @override
  Future<MovieList> getLastTopRatedMovieList() {
    // TODO: implement getLastTopRatedMovieList
    throw UnimplementedError();
  }

  @override
  Future<MovieList> getLastUpComingMovieList() {
    // TODO: implement getLastUpComingMovieList
    throw UnimplementedError();
  }

  @override
  Future<MovieAccountStates> getLastMovieAccountStates(
      {String sessionId, int movieId}) {
    // TODO: implement getLastMovieAccountStates
    throw UnimplementedError();
  }

  @override
  Future<void> cacheMovieList(String listType, MovieList movieList) {
    return sharedPreferences.setString(listType, movieList.toJson());
  }
}
