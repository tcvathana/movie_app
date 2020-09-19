import 'package:http/http.dart' as http;
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

}