import 'package:http/http.dart' as http;
import 'package:movie_app/data/models/account_states.dart';
import 'dart:convert';
import '../config.dart';

Future<bool> markAsFavorite(String sessionId, int mediaId, bool fav) async {
  http.Response response = await http.post(
      "$SERVICE_URL/account/{account_id}/favorite?api_key=$API_KEY&session_id=$sessionId",
      body: {
        "media_type": "movie",
        "media_id": mediaId.toString(),
        "favorite": fav.toString()
      }
  );
  print("fav.toString(): ${fav.toString()}");
  if (response.statusCode == 200) {
    print("deleted");
    return true;
  } else if(response.statusCode == 201){
    print("created");
    return true;
  } else if(response.statusCode == 401){
    return false;
  }
}
Future<bool> addToWatchlist(String sessionId, int mediaId, bool wat) async {
  http.Response response = await http.post(
      "$SERVICE_URL/account/{account_id}/watchlist?api_key=$API_KEY&session_id=$sessionId",
      body: {
        "media_type": "movie",
        "media_id": mediaId.toString(),
        "watchlist": wat.toString()
      }
  );
  print("wat.toString(): ${wat.toString()}");
  if (response.statusCode == 200) {
    print("satus: 200");
    return true;
  } else if(response.statusCode == 201){
    print("status: 201");
    return true;
  } else if(response.statusCode == 401){
    return false;
  }
}

// Movie Account State
AccountStates _parseDataAccountStates(String input) {
  Map<String, dynamic> map = json.decode(input);
  AccountStates accStates = AccountStates.fromMap(map);
  return accStates;
}

Future<AccountStates> fetchDataAccountState(String sessionId, int movieId) async {
  http.Response response = await http.get(
      "$SERVICE_URL/movie/$movieId/account_states?api_key=$API_KEY&session_id=$sessionId");
  if (response.statusCode == 200) {
    return _parseDataAccountStates(response.body);
  } else {
    throw Exception("Error ${response.toString()}");
  }
}