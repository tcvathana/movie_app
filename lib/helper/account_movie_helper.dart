import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/data/models/movie_account_states.dart';
import 'dart:convert';
import '../config.dart';

/*Future<bool> markAsFavorite({
  String sessionId,
  int mediaId,
  bool favorite,
}) async {
  http.Response response = await http.post(
      "$SERVICE_URL/account/{account_id}/favorite?api_key=$API_KEY&session_id=$sessionId",
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
}*/

/*Future<bool> addToWatchlist({
  String sessionId,
  int mediaId,
  bool watchlist,
}) async {
  http.Response response = await http.post(
      "$SERVICE_URL/account/{account_id}/watchlist?api_key=$API_KEY&session_id=$sessionId",
      body: {
        "media_type": "movie",
        "media_id": mediaId.toString(),
        "watchlist": watchlist.toString()
      });
  print("wat.toString(): ${watchlist.toString()}");
  if (response.statusCode == 200) {
    print("status: 200");
    return true;
  } else if (response.statusCode == 201) {
    print("status: 201");
    return true;
  } else {
    return false;
  }
}*/

// Movie Account State
Future<MovieAccountStates> fetchDataAccountState({
  @required String sessionId,
  @required int movieId,
}) async {
  http.Response response = await http.get(
      "$SERVICE_URL/movie/$movieId/account_states?api_key=$API_KEY&session_id=$sessionId");
  if (response.statusCode == 200) {
    return MovieAccountStates.fromJson(response.body);
  } else {
    throw Exception("Error ${response.toString()}");
  }
}
