import 'package:flutter/material.dart';
import 'package:movie_app/data/repositories/authentication_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/account/favorite_list_button.dart';
import '../widgets/account/watchlist_button.dart';
import '../widgets/account/container/user_profile_container.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refresh,
          ),
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
            ),
            color: Colors.red,
            onPressed: logout,
          )
        ],
      ),
      body: Container(
        color: Colors.black87,
        height: MediaQuery.of(context).size.height,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                UserProfileContainer(),
                Divider(
                  color: Colors.white,
                ),
                Column(
                  children: <Widget>[
                    FavoriteListButton(),
                    SizedBox(
                      height: 10,
                    ),
                    WatchlistButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AuthenticationRepository _authRepository = new AuthenticationRepository();
    await _authRepository.deleteSession(
      sessionId: prefs.getString("session_id"),
    );
    prefs.remove("session_id");
    prefs.remove("account");
  }
}
