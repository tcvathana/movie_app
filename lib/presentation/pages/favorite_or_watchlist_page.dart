import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';

import 'account_page.dart';
import 'movie_detail_page.dart';

class FavoriteOrWatchlistPage extends StatefulWidget {
  String title = "";
  List<Result> listResult = [];

  FavoriteOrWatchlistPage(this.title, this.listResult);

  @override
  _FavoriteOrWatchlistPageState createState() =>
      _FavoriteOrWatchlistPageState();
}

class _FavoriteOrWatchlistPageState extends State<FavoriteOrWatchlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.black87,
      title: Text(widget.title),
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
    );
  }

  Widget _buildBody() {
    return Container(
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
                widget.title,
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
                IconButton(
                  icon: Icon(
                    Icons.sort,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.listResult = widget.listResult.reversed.toList();
                    });
                  },
                ),
              ],
            ),
            Divider(
              color: Colors.white.withOpacity(0.8),
            ),
            _buildMovieList(widget.listResult),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieList(List<Result> _listRes) {
    List<Widget> listWidget = [];
    for (Result res in _listRes) {
      listWidget.add(_buildMovieItem(res));
      listWidget.add(
        Divider(
          color: Colors.white.withOpacity(0.8),
        ),
      );
    }

    return Column(
      children: listWidget,
    );
  }

  Widget _buildMovieItem(Result res) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: MovieDetailPage(res.id, res.title),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            Container(
              width: 100,
              child: CachedNetworkImage(
                imageUrl: "https://image.tmdb.org/t/p/w500${res.posterPath}",
              ),
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width - 100 - 10 - 10,
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    res.title,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    DateFormat.yMMMd().format(res.releaseDate),
                    style: TextStyle(color: Colors.grey),
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.8),
                  ),
                  Expanded(
                    child: Text(
                      res.overview,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 14,
                        ),
                        Text(
                          res.voteAverage.toString(),
                          style: TextStyle(color: Colors.amber, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
