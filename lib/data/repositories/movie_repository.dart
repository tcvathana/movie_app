import 'dart:async';
import 'package:meta/meta.dart';
import '../../core/network/network_info.dart';
import '../../domain/repositories/i_movie_repository.dart';
import '../data_sources/local/movie_local_data_source.dart';
import '../data_sources/remote/movie_remote_data_source.dart';
import '../models/movie_list.dart';

typedef Future<MovieList> _MovieListName();

class MovieRepository implements IMovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<MovieList> getNowPlayingMovieList() async {
    return await _getMovieList(
      "now_playing",
      remoteDataSource.fetchNowPlayingMovieList,
    );
  }

  @override
  Future<MovieList> getMostPopularMovieList() async {
    return await _getMovieList(
      "popular_movie",
      remoteDataSource.fetchMostPopularMovieList,
    );
  }

  @override
  Future<MovieList> getTopRatedMovieList() async {
    return await _getMovieList(
      "top_rated",
      remoteDataSource.fetchTopRatedMovieList,
    );
  }

  @override
  Future<MovieList> getUpComingMovieList() async {
    return await _getMovieList(
      "top_rated",
      remoteDataSource.fetchUpComingMovieList,
    );
  }

  Future<MovieList> _getMovieList(
    String listName,
    _MovieListName _movieListName,
  ) async {
    if (await networkInfo.isConnected) {
      final remoteMovieList = await _movieListName();
      localDataSource.cacheMovieList(listName, remoteMovieList);
      return remoteMovieList;
    } else {
      return localDataSource.getMovieList(listName);
    }
  }
}
