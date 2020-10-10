import 'package:meta/meta.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/data/data_sources/local/account_local_data_source.dart';
import 'package:movie_app/data/data_sources/remote/account_remote_data_source.dart';
import 'package:movie_app/data/models/movie_list.dart';
import '../models/account.dart';
import '../../domain/repositories/i_account_repository.dart';

class AccountRepository implements IAccountRepository {
  final AccountRemoteDataSource remoteDataSource;
  final AccountLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const AccountRepository({
    this.networkInfo,
    this.remoteDataSource,
    this.localDataSource,
  });

  @override
  Future<Account> getAccountDetails({@required String sessionId}) async {
    if (await networkInfo.isConnected) {
      final remoteAccount = await remoteDataSource.getAccountDetails(
        sessionId: sessionId,
      );
      localDataSource.cacheAccountDetails(account: remoteAccount);
      return remoteAccount;
    } else {
      return localDataSource.getAccountDetails();
    }
  }

  // List
  @override
  Future<MovieList> getFavoriteMovieList({
    @required String sessionId,
    @required String accountId,
  }) async {
    if (await networkInfo.isConnected) {
      final remoteMovieList = await remoteDataSource.getFavoriteMovieList(
        sessionId: sessionId,
        accountId: accountId,
      );
      localDataSource.cacheFavoriteMovieList(
        favoriteMovieList: remoteMovieList,
      );
      return remoteMovieList;
    } else {
      return localDataSource.getFavoriteMovieList();
    }
  }

  @override
  Future<MovieList> getWatchlistMovieList({
    @required String sessionId,
    @required String accountId,
  }) async {
    if (await networkInfo.isConnected) {
      final remoteMovieList = await remoteDataSource.getWatchlistMovieList(
        sessionId: sessionId,
        accountId: accountId,
      );
      localDataSource.cacheWatchlistMovieList(
        watchlistMovie: remoteMovieList,
      );
      return remoteMovieList;
    } else {
      return localDataSource.getWatchlistMovieList();
    }
  }

  // USE_CASE
  @override
  Future<String> markAsFavorite({
    @required String sessionId,
    @required int accountId,
    @required int mediaId,
    @required bool favorite,
  }) {
    return remoteDataSource.markAsFavorite(
      sessionId: sessionId,
      accountId: accountId,
      mediaId: mediaId,
      favorite: favorite,
    );
  }

  @override
  Future<String> addToWatchlist({
    @required String sessionId,
    @required int accountId,
    @required int mediaId,
    @required bool watchlist,
  }) {
    return remoteDataSource.addToWatchlist(
      sessionId: sessionId,
      accountId: accountId,
      mediaId: mediaId,
      watchlist: watchlist,
    );
  }
}
