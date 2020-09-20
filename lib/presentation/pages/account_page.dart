import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './favorite_or_watchlist_page.dart';
import '../../data/repositories/account_repository.dart';
import '../../data/repositories/authentication_repository.dart';
import '../../data/models/account.dart';
import '../../data/models/movie_list.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  AccountRepository _accountRepository = new AccountRepository();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //account page staff
  Future<Account> dataFetched;
  Future<List<MovieResult>> dataFetchedFavoriteList;

  MovieList _favoriteMovieList;
  MovieList _watchlistMovieList;

  void initList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String session = prefs.getString("session_id");
    _accountRepository
        .fetchFavoriteMovieList(sessionId: session)
        .then((value) => _favoriteMovieList = value);
    _accountRepository
        .fetchWatchlistMovieList(sessionId: session)
        .then((value) => _watchlistMovieList = value);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.dataFetched = _accountRepository.getAccountPreference();
    initList();
    return Scaffold(
      appBar: _buildAppBar(),
      key: _scaffoldKey,
      body: _buildBody(context),
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
              dataFetched = _accountRepository.getAccountPreference();
            });
          },
        ),
        IconButton(
          icon: Icon(
            Icons.exit_to_app,
          ),
          color: Colors.red,
          onPressed: () {},
        )
      ],
    );
  }

  Widget _buildFuture() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<Account>(
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

  Widget _buildBody(context) {
    return Container(
      color: Colors.black87,
      height: MediaQuery.of(context).size.height,
      child: _buildFuture(),
    );
  }

  Widget _buildProfile(Account userData) {
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
                        title: "Favorite Page",
                        movieList: _favoriteMovieList,
                      ),
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
                        title: "Watchlist Page",
                        movieList: _watchlistMovieList,
                      ),
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
}
