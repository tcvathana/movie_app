import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/repositories/account_repository.dart';
import '../../data/models/movie_list.dart';
import '../widgets/movie/movie_item_horizontal.dart';
import 'account_page.dart';

class WatchlistPage extends StatelessWidget {
  final AccountRepository _accountRepository = new AccountRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Watchlist"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.account_circle,
            ),
            color: Colors.blueAccent,
            tooltip: "Account Page",
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: AccountPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black87,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10, top: 15),
                child: Text(
                  "Watchlist",
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(0.8),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Sorted by Create At",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.white.withOpacity(0.8),
              ),
              FutureBuilder<SharedPreferences>(
                  future: SharedPreferences.getInstance(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      String sessionId = snapshot.data.getString("session_id");
                      return FutureBuilder<MovieList>(
                        future: _accountRepository.fetchWatchlistMovieList(
                            sessionId: sessionId),
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.done) {
                            if (snap.hasError) {
                              return Center(
                                child: Text(
                                  "UnAuthenticated",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25
                                  ),
                                ),
                              );
                            }
                            List<MovieResult> movies = snap.data.results;
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height - 180,
                              child: ListView.separated(
                                itemCount: movies.length,
                                itemBuilder: (context, index) {
                                  return MovieItemHorizontal(movieResult: movies[index]);
                                },
                                separatorBuilder: (context, index) {
                                  return Divider();
                                },
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    } else {
                      return Container();
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
