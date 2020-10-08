import 'package:http/http.dart' as http;
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/data/data_sources/local/account_local_data_source.dart';
import 'package:movie_app/data/data_sources/remote/account_remote_data_source.dart';
import 'package:movie_app/data/models/movie_list.dart';
import '../models/account.dart';
import '../../domain/repositories/i_account_repository.dart';
import '../../config.dart';

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
  Future<Account> getAccountDetails({String sessionId}) async {
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
    String sessionId,
    String accountId,
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
    String sessionId,
    String accountId,
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
  Future<bool> addToWatchlist({
    String sessionId,
    int mediaId,
    bool watchlist,
  }) async {
    http.Response response = await http.post(
        "$BASE_URL/account/{account_id}/watchlist?api_key=$API_KEY&session_id=$sessionId",
        body: {
          "media_type": "movie",
          "media_id": mediaId.toString(),
          "watchlist": watchlist.toString()
        });
    if (response.statusCode == 200) {
      print("status: 200");
      return true;
    } else if (response.statusCode == 201) {
      print("status: 201");
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> markAsFavorite({
    String sessionId,
    int mediaId,
    bool favorite,
  }) async {
    http.Response response = await http.post(
        "$BASE_URL/account/{account_id}/favorite?api_key=$API_KEY&session_id=$sessionId",
        body: {
          "media_type": "movie",
          "media_id": mediaId.toString(),
          "favorite": favorite.toString()
        });
    print("fav.toString(): ${favorite.toString()}");
    if (response.statusCode == 200) {
      print("deleted");
      return true;
    } else if (response.statusCode == 201) {
      print("created");
      return true;
    } else {
      return false;
    }
  }
}
