import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../config.dart';
import '../../models/movie_list.dart';
import '../../models/account.dart';

abstract class IAccountRemoteDataSource {
  Future<Account> getAccountDetails({String sessionId});

  // List
  Future<MovieList> getFavoriteMovieList({String sessionId, String accountId});

  Future<MovieList> getWatchlistMovieList({String sessionId, String accountId});

  // USE_CASE
  Future<bool> markAsFavorite({String sessionId, int mediaId, bool favorite});

  Future<bool> addToWatchlist({String sessionId, int mediaId, bool watchlist});
}

class AccountRemoteDataSource implements IAccountRemoteDataSource {

  @override
  Future<Account> getAccountDetails({String sessionId})async {
    http.Response response = await http.get(
      "$BASE_URL/account?api_key=$API_KEY&session_id=$sessionId",
    );
    if (response.statusCode == 200) {
      return Account.fromJson(response.body);
    } else {
      final responseMap = json.decode(response.body);
      final String statusMessage = responseMap["status_message"];
      throw Exception(statusMessage);
    }
  }

  @override
  Future<MovieList> getFavoriteMovieList({String sessionId,  String accountId}) async {
    http.Response response = await http.get(
        "$BASE_URL/account/$accountId/favorite/movies?api_key=$API_KEY&session_id=$sessionId&sort_by=created_at.asc&page=1");
    if (response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      final responseMap = json.decode(response.body);
      final String statusMessage = responseMap["status_message"];
      throw Exception(statusMessage);
    }
  }

  @override
  Future<MovieList> getWatchlistMovieList({String sessionId, String accountId}) async {
    http.Response response = await http.get(
        "$BASE_URL/account/$accountId/watchlist/movies?api_key=$API_KEY&session_id=$sessionId&sort_by=created_at.asc&page=1");
    if (response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      final responseMap = json.decode(response.body);
      final String statusMessage = responseMap["status_message"];
      throw Exception(statusMessage);
    }
  }

  @override
  Future<bool> markAsFavorite({String sessionId, int mediaId, bool favorite}) {
    // TODO: implement markAsFavorite
    throw UnimplementedError();
  }

  @override
  Future<bool> addToWatchlist({String sessionId, int mediaId, bool watchlist}) {
    // TODO: implement addToWatchlist
    throw UnimplementedError();
  }
}
