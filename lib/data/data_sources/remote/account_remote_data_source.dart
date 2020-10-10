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
  Future<String> markAsFavorite(
      {String sessionId, int accountId, int mediaId, bool favorite});

  Future<String> addToWatchlist(
      {String sessionId, int accountId, int mediaId, bool watchlist});
}

class AccountRemoteDataSource implements IAccountRemoteDataSource {
  @override
  Future<Account> getAccountDetails({String sessionId}) async {
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
  Future<MovieList> getFavoriteMovieList(
      {String sessionId, String accountId}) async {
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
  Future<MovieList> getWatchlistMovieList(
      {String sessionId, String accountId}) async {
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
  Future<String> markAsFavorite({
    String sessionId,
    int accountId,
    int mediaId,
    bool favorite,
  }) async {
    final body = json.encode(
      {
        "media_type": "movie",
        "media_id": mediaId,
        "favorite": favorite,
      },
    );
    http.Response response = await http.post(
      "$BASE_URL/account/$accountId/favorite?api_key=$API_KEY&session_id=$sessionId",
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );
    final responseMap = json.decode(response.body);
    if (response.statusCode == 200) {
      final String statusMessage = responseMap["status_message"];
      return statusMessage;
    } else if (response.statusCode == 201) {
      final String statusMessage = responseMap["status_message"];
      return statusMessage;
    } else {
      final String statusMessage = responseMap["status_message"];
      throw Exception(statusMessage);
    }
  }

  @override
  Future<String> addToWatchlist({
    String sessionId,
    int accountId,
    int mediaId,
    bool watchlist,
  }) async {
    final body = json.encode(
      {
        "media_type": "movie",
        "media_id": mediaId,
        "watchlist": watchlist,
      },
    );
    http.Response response = await http.post(
      "$BASE_URL/account/$accountId/watchlist?api_key=$API_KEY&session_id=$sessionId",
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );
    final responseMap = json.decode(response.body);
    if (response.statusCode == 200) {
      final String statusMessage = responseMap["status_message"];
      return statusMessage;
    } else if (response.statusCode == 201) {
      final String statusMessage = responseMap["status_message"];
      return statusMessage;
    } else {
      final String statusMessage = responseMap["status_message"];
      throw Exception(statusMessage);
    }
  }
}
