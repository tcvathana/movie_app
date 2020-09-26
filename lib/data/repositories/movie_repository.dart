import 'dart:async';
import 'package:meta/meta.dart';
import '../../core/network/network_info.dart';
import '../../domain/repositories/i_movie_repository.dart';
import '../data_sources/local/movie_local_data_source.dart';
import '../data_sources/remote/movie_remote_data_source.dart';
import '../models/movie_account_states.dart';
import '../models/movie_list.dart';

class MovieRepository implements IMovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo
  });

  @override
  Future<MovieList> getNowPlayingMovieList() async {
    if(await networkInfo.isConnected) {
      final remoteNowPlaying = await remoteDataSource.fetchNowPlayingMovieList();
      localDataSource.cacheMovieList("now_playing", remoteNowPlaying);
      return remoteNowPlaying;
    } else {
      return localDataSource.getLastNowPlayingMovieList();
    }

  }

  @override
  Future<MovieList> getMostPopularMovieList() async {
    return remoteDataSource.fetchMostPopularMovieList();
  }

  @override
  Future<MovieList> getTopRatedMovieList() async {
    return remoteDataSource.fetchTopRatedMovieList();
  }

  @override
  Future<MovieList> getUpComingMovieList() async {
    return remoteDataSource.fetchUpComingMovieList();
  }

  //
  @override
  Future<MovieAccountStates> getMovieAccountStates({
    @required String sessionId,
    @required int movieId,
  }) async {
    return remoteDataSource.fetchMovieAccountStates(
      sessionId: sessionId,
      movieId: movieId,
    );
  }
}
