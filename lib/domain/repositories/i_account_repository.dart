import 'package:meta/meta.dart';
import '../../data/models/account.dart';
import '../../data/models/movie_list.dart';

abstract class IAccountRepository {
  Future<Account> getAccountDetails({@required String sessionId});

  //
  Future<MovieList> getFavoriteMovieList({
    @required String sessionId,
    @required String accountId,
  });

  Future<MovieList> getWatchlistMovieList({
    @required String sessionId,
    @required String accountId,
  });

  // USE_CASE
  Future<String> markAsFavorite({
    @required String sessionId,
    @required int accountId,
    @required int mediaId,
    @required bool favorite,
  });

  Future<String> addToWatchlist({
    @required String sessionId,
    @required int accountId,
    @required int mediaId,
    @required bool watchlist,
  });
}
