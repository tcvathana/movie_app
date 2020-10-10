import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/account.dart';
import '../../models/movie_list.dart';

abstract class IAccountLocalDataSource {
  Future<Account> getAccountDetails();

  // List
  Future<MovieList> getFavoriteMovieList();

  Future<MovieList> getWatchlistMovieList();

  Future<void> cacheAccountDetails({@required Account account});

  Future<void> cacheFavoriteMovieList({@required MovieList favoriteMovieList});

  Future<void> cacheWatchlistMovieList({@required MovieList watchlistMovie});
}

class AccountLocalDataSource implements IAccountLocalDataSource {
  final SharedPreferences sharedPreferences;

  AccountLocalDataSource({this.sharedPreferences});

  @override
  Future<Account> getAccountDetails() {
    final String jsonString = sharedPreferences.getString("/account");
    if (jsonString != null) {
      return Future.value(Account.fromJson(jsonString));
    } else {
      throw Exception("Cache error");
    }
  }

  @override
  Future<MovieList> getFavoriteMovieList() {
    final String jsonString =
        sharedPreferences.getString("/account/favorite/movie");
    if (jsonString != null) {
      return Future.value(MovieList.fromJson(jsonString));
    } else {
      throw Exception("Cache error");
    }
  }

  @override
  Future<MovieList> getWatchlistMovieList({String sessionId}) {
    final String jsonString = sharedPreferences.getString(
      "/account/watchlist/movie",
    );
    if (jsonString != null) {
      return Future.value(MovieList.fromJson(jsonString));
    } else {
      throw Exception("Cache error");
    }
  }

  @override
  Future<void> cacheAccountDetails({@required Account account}) {
    return sharedPreferences.setString(
      "/account",
      account.toJson(),
    );
  }

  @override
  Future<void> cacheFavoriteMovieList({@required MovieList favoriteMovieList}) {
    return sharedPreferences.setString(
      "/account/favorite/movie",
      favoriteMovieList.toJson(),
    );
  }

  @override
  Future<void> cacheWatchlistMovieList({@required MovieList watchlistMovie}) {
    return sharedPreferences.setString(
      "/account/watchlist/movie",
      watchlistMovie.toJson(),
    );
  }
}
