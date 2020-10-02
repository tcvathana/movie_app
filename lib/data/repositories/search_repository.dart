import 'package:meta/meta.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/data/data_sources/local/search_local_data_source.dart';
import '../data_sources/remote/search_remote_data_source.dart';
import '../models/movie_list.dart';
import '../../domain/repositories/i_search_repository.dart';

class SearchRepository implements ISearchRepository {
  final SearchRemoteDataSource remoteDataSource;
  final SearchLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SearchRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<MovieList> getSearchMovie({@required String query}) async {
    if (await networkInfo.isConnected) {
      final remoteSearchMovie = await remoteDataSource.fetchSearchMovie(
        query: query,
      );
      localDataSource.cacheSearchMovie(
        query: query,
        movieList: remoteSearchMovie,
      );
      return remoteSearchMovie;
    } else {
      return localDataSource.getSearchMovie(query: query);
    }
  }
}
