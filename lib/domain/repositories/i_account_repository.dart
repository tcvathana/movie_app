import '../../data/models/account.dart';
import '../../data/models/movie_list.dart';

abstract class IAccountRepository {
  Future<Account> getAccountDetails({String sessionId});

  //Future<Account> saveAccountPreference({String sessionId});

  //Future<Account> getAccountPreference();

  //
  Future<MovieList> getFavoriteMovieList({String sessionId});

  Future<MovieList> getWatchlistMovieList({String sessionId});

  // USE_CASE
  Future<bool> markAsFavorite({String sessionId, int mediaId, bool favorite});

  Future<bool> addToWatchlist({String sessionId, int mediaId, bool watchlist});
}
