import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/data/repositories/authentication_repository.dart';
import './favorite_or_watchlist_page.dart';
import 'package:movie_app/data/models/user_account.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/verifyUser.dart';
import '../../helper/account_movie_helper.dart';
import '../../data/models/movie_list.dart';

Future<bool> changeLoginStatusPreference(bool status) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isLogedIn", status);
  return prefs.getBool("isLogedIn");
}

Future<bool> getLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool status = prefs.getBool("isLogedIn");
  return status;
}

//UserAccount
Future<UserAccount> saveAccountPreference(sessionId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("session_id", sessionId);
  UserAccount user = UserAccount(
      name: "",
      username: "",
      id: 0,
      includeAdult: false,
      iso6391: "",
      iso31661: "",
      avatar: Avatar(gravatar: Gravatar(hash: "")));
  Future<UserAccount> future = fetchAccountDetails(sessionId);
  future.then((value) {
    prefs.setString("UserAccount_name", value.name);
    prefs.setString("UserAccount_username", value.username);
    prefs.setInt("UserAccount_id", value.id);
    prefs.setBool("UserAccount_includeAdult", value.includeAdult);
    prefs.setString("UserAccount_iso6391", value.iso6391);
    prefs.setString("UserAccount_iso31661", value.iso31661);
    prefs.setString(
        "UserAccount_avatar_gravatar_hash", value.avatar.gravatar.hash);
    print("value.id: ${value.id}");
    return value;
  });
  /*prefs.setString("UserAccount_name", user.name);
  prefs.setString("UserAccount_username", user.username);
  prefs.setInt("UserAccount_id", user.id);
  prefs.setBool("UserAccount_includeAdult", user.includeAdult);
  prefs.setString("UserAccount_iso6391", user.iso6391);
  prefs.setString("UserAccount_iso31661", user.iso31661);
  prefs.setString("UserAccount_avatar_gravatar_hash", user.avatar.gravatar.hash);*/
//  print("user.username:"+user.username);
//  print("saveAccountPreference, user.username: "+user.username);
//  return user;
}

Future<UserAccount> getAccountPreference() async {
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
  UserAccount user = UserAccount(
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
//  print("prefs.getString: ${prefs.getString("UserAccount_name")}");
  return user;
}

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  AuthenticationRepository _authenticationRepository =
      new AuthenticationRepository();

  //login staff
  var _usernameCtrl = TextEditingController();
  var _passwordCtrl = TextEditingController();

  bool _isLoggedIn;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //account page staff
  Future<UserAccount> dataFetched;
  Future<List<MovieResult>> dataFetchedFavoriteList;

  List<MovieResult> _favoriteMovieList;
  List<MovieResult> _watchlistMovieList;

  void initList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String session = prefs.getString("session_id");
    fetchDataFavoriteMovie(session).then((value) => _favoriteMovieList = value);
    fetchDataWatchlistMovie(session)
        .then((value) => _watchlistMovieList = value);
  }

  @override
  void initState() {
    super.initState();
    getLoginStatus().then(updateLogin);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn == null) {
      _isLoggedIn = false;
    }
    if (_isLoggedIn == true) {
      this.dataFetched = getAccountPreference();
      initList();
    }
    return Scaffold(
      appBar: _buildAppBar(),
      key: _scaffoldKey,
      body:
          _isLoggedIn == false ? _buildBodyLogin(context) : _buildBody(context),
    );
  }

  Widget _buildBodyLogin(context) {
    return Container(
      color: Colors.black87,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black26,
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                    controller: _usernameCtrl,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter Username...",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(
                        Icons.account_circle,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  TextField(
                    controller: _passwordCtrl,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Enter Password...",
                      hintStyle: TextStyle(color: Colors.grey),
                      icon: Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      Future<String> future =
                          _authenticationRepository.createSession(
                        username: _usernameCtrl.text,
                        password: _passwordCtrl.text,
                      );
                      String session = '';
                      future.then((value) async {
                        session = value;
                        print("Login Page, My session is: $session");
                        if (session != null && session != '') {
                          fetchDataFavoriteMovie(session)
                              .then((value) => _favoriteMovieList = value);
                          saveAccountPreference(session);
                          saveLogin(true);
                        } else {
                          _scaffoldKey.currentState.showSnackBar(new SnackBar(
                              content: new Text(
                            "Login Fails",
                            style: TextStyle(color: Colors.red),
                          )));
                        }
                      });
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black87,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              dataFetched = getAccountPreference();
            });
          },
        ),
//        IconButton(
//          icon: Icon(Icons.search),
//          onPressed: () {},
//        ),
        _isLoggedIn == true
            ? IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                ),
                color: Colors.red,
                onPressed: () {
                  logOutAccount();
                },
              )
            : IconButton(
                icon: Icon(
                  Icons.account_circle,
                ),
                color: Colors.blueAccent,
                tooltip: "Account Page",
                onPressed: () {},
              ),
      ],
    );
  }

  _buildFuture() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<UserAccount>(
        future: this.dataFetched,
//        future: getAccountPreference(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return _buildProfile(snapshot.data);
            } else {
              return Center(
                child: Text("No data available."),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  _buildBody(context) {
    return Container(
      color: Colors.black87,
      height: MediaQuery.of(context).size.height,
      child: _buildFuture(),
    );
  }

  _buildProfile(UserAccount userData) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.account_circle,
                      color: Colors.grey,
                      size: 35,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                        userData.username == null ? "" : "${userData.username}",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Divider(
            color: Colors.white,
          ),
          Column(
            children: <Widget>[
              RaisedButton(
                color: Colors.redAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: FavoriteOrWatchlistPage(
                          "Favorite Page", _favoriteMovieList),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Favourite List",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                splashColor: Colors.blue[900],
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: FavoriteOrWatchlistPage(
                          "Watchlist Page", _watchlistMovieList),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Watchlist",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void updateLogin(bool value) {
    setState(() {
      this._isLoggedIn = value;
    });
  }

  void saveLogin(bool val) {
    changeLoginStatusPreference(val).then(updateLogin);
  }

  void logOutAccount() async {
    setState(() {
      this._isLoggedIn = false;
    });
    changeLoginStatusPreference(false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("UserAccount_name");
    prefs.remove("UserAccount_username");
    prefs.remove("UserAccount_id");
    prefs.remove("UserAccount_includeAdult");
    prefs.remove("UserAccount_iso6391");
    prefs.remove("UserAccount_iso31661");
    prefs.remove("UserAccount_avatar_gravatar_hash");
    prefs.setString("session_id", 'null');
  }
}
