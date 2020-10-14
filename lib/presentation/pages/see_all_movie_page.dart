import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../data/models/movie_list.dart';
import '../widgets/movie/movie_item_horizontal.dart';
import './account_page.dart';

class SeeMoreMoviesPage extends StatefulWidget {
  String title;
  String sortedBy;

  MovieList movieList;

  SeeMoreMoviesPage({
    this.title,
    this.sortedBy,
    this.movieList,
  });

  @override
  _SeeMoreMoviesPageState createState() => _SeeMoreMoviesPageState();
}

class _SeeMoreMoviesPageState extends State<SeeMoreMoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Movie Trailer"),
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
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Container(
          color: Colors.black87,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10, top: 15),
                child: Text(
                  widget.title,
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(0.8),
              ),
              Container(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "20 Titles",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Sorted by ${widget.sortedBy}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(0.8),
              ),
              Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: widget.movieList.results.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: Colors.white.withOpacity(0.8),
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return MovieItemHorizontal(
                      movieResult: widget.movieList.results[index],
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onRefresh() {
    // TODO: Implement onRefresh
    return Future.value(0);
  }
}
