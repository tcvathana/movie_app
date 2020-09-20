import '../../data/models/account.dart';
import '../../data/models/movie_list.dart';

abstract class IAccountRepository {
  Future<Account> fetchAccountDetails({String sessionId});
  Future<Account> saveAccountPreference({String sessionId});
  Future<Account> getAccountPreference();
  //
  Future<MovieList> fetchFavoriteMovieList({String sessionId});
  Future<MovieList> fetchWatchlistMovieList({String sessionId});
}