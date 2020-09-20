import 'package:http/http.dart' as http;
import 'package:movie_app/data/models/movie_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/account.dart';
import '../../domain/repositories/i_account_repository.dart';
import '../../config.dart';

class AccountRepository implements IAccountRepository {
  @override
  Future<Account> fetchAccountDetails({String sessionId}) async {
    http.Response response = await http.get(
      "$SERVICE_URL/account?api_key=$API_KEY&session_id=$sessionId",
    );
    if (response.statusCode == 200) {
      return Account.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }

  @override
  Future<Account> getAccountPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Assign prefs value to variable
    String name = prefs.getString("UserAccount_name") ?? "default";
    String username = prefs.getString("UserAccount_username") ?? "default";
    int id = prefs.getInt("UserAccount_id") ?? 0;
    bool includeAdult = prefs.getBool("UserAccount_includeAdult") ?? false;
    String iso6391 = prefs.getString("UserAccount_iso6391") ?? "default";
    String iso31661 = prefs.getString("UserAccount_iso31661") ?? "default";
    String hash =
        prefs.getString("UserAccount_avatar_gravatar_hash") ?? "default";
    //Create Object
    Account user = Account(
      name: name,
      username: username,
      id: id,
      includeAdult: includeAdult,
      iso6391: iso6391,
      iso31661: iso31661,
      avatar: Avatar(
        gravatar: Gravatar(hash: hash),
      ),
    );
    return user;
  }

  @override
  Future<Account> saveAccountPreference({String sessionId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("session_id", sessionId);
    Account user;
    await fetchAccountDetails(sessionId: sessionId).then((value) {
      prefs.setString("UserAccount_name", value.name);
      prefs.setString("UserAccount_username", value.username);
      prefs.setInt("UserAccount_id", value.id);
      prefs.setBool("UserAccount_includeAdult", value.includeAdult);
      prefs.setString("UserAccount_iso6391", value.iso6391);
      prefs.setString("UserAccount_iso31661", value.iso31661);
      prefs.setString(
          "UserAccount_avatar_gravatar_hash", value.avatar.gravatar.hash);
      print("value.id: ${value.id}");
      user = value;
      return value;
    });
    return user;
  }

  //
  @override
  Future<MovieList> fetchFavoriteMovieList({String sessionId}) async {
    http.Response response = await http.get(
        "$SERVICE_URL/account/{account_id}/favorite/movies?api_key=$API_KEY&session_id=$sessionId&sort_by=created_at.asc&page=1");
    if (response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }

  @override
  Future<MovieList> fetchWatchlistMovieList({String sessionId}) async {
    http.Response response = await http.get(
        "$SERVICE_URL/account/{account_id}/watchlist/movies?api_key=$API_KEY&session_id=$sessionId&sort_by=created_at.asc&page=1");
    if (response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
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
  }

  @override
  Future<bool> markAsFavorite({
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
  }
}
