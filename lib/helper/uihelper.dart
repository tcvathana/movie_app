import 'package:flutter/material.dart';
import 'package:movie_app/config.dart';
import '../data/models/movie.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../presentation/pages/see_allmovie_page.dart';
import '../presentation/pages/movie_detail_page.dart';

List<Result> _listPopularMovie = [];
List<Result> _listTopRatedMovie = [];
List<Result> _listUpComingMovie = [];

buildPopularMovies(context, Future<List<Result>> _fetchData) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.only(left: 10, top: 15, bottom: 30),
    margin: EdgeInsets.only(top: 20),
    color: Colors.white.withOpacity(0.08),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Most Popular Movies",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            FlatButton(
              color: Colors.transparent,
              child: Text(
                "SEE ALL",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: SeeAllMoviesPage(
                        "Most Poppular Movie", "Popularity", _listPopularMovie),
                  ),
                );
              },
            ),
          ],
        ),
        FutureBuilder<List<Result>>(
          future: _fetchData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                _listPopularMovie = snapshot.data;
                return _buildPopularMoviesListView(context, _listPopularMovie);
              } else {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    ),
  );
}

Widget _buildPopularMoviesListView(context, List<Result> data) {
  List<Widget> list = [];
  Widget row;
  for (Result res in data) {
    row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          res.popularity.toString(),
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 16,
            ),
            Text(
              res.voteAverage.toString(),
              style: TextStyle(color: Colors.amber, fontSize: 16),
            ),
          ],
        ),
      ],
    );
    list.add(buildMovieItem(context, res, row));
  }

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: list,
    ),
  );
}

Widget buildMovieItem(context, Result result, Widget _otherWidget) {
  return Card(
    color: Colors.white.withOpacity(0.15),
    child: InkWell(
      highlightColor: Colors.black26,
      splashColor: Colors.black26,
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: MovieDetailPage(result.id, result.title),
          ),
        );
      },
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              CachedNetworkImage(
                height: 240,
                width: 160,
                imageUrl: "$IMAGE_BASE_URL/w500${result.posterPath}",
                placeholder: (context, url) => Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 15),
            width: 160,
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  result.title,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                _otherWidget
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

//Top Rate movie
Widget buildTopRateMovies(context, Future<List<Result>> _fetchData) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.only(left: 10, top: 15, bottom: 30),
    margin: EdgeInsets.only(top: 20),
    color: Colors.white.withOpacity(0.08),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Top Rated Movies",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            FlatButton(
              color: Colors.transparent,
              child: Text(
                "SEE ALL",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: SeeAllMoviesPage(
                        "Top Rated Movie", 'Top Rate', _listTopRatedMovie),
                  ),
                );
              },
            ),
          ],
        ),
        FutureBuilder<List<Result>>(
          future: _fetchData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                _listTopRatedMovie = snapshot.data;
                return _buildTopRateMoviesListView(context, _listTopRatedMovie);
              } else {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    ),
  );
}

Widget _buildTopRateMoviesListView(context, List<Result> data) {
  List<Widget> list = [];
  Widget row;
  for (Result res in data) {
    row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          res.voteCount.toString(),
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.star,
              color: Colors.amber,
              size: 16,
            ),
            Text(
              res.voteAverage.toString(),
              style: TextStyle(color: Colors.amber, fontSize: 16),
            ),
          ],
        ),
      ],
    );
    list.add(buildMovieItem(context, res, row));
  }

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: list,
    ),
  );
}

//Up Coming
Widget buildUpComingMovies(context, Future<List<Result>> _fetchData) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.only(left: 10, top: 15, bottom: 30),
    margin: EdgeInsets.only(top: 20),
    color: Colors.white.withOpacity(0.08),
    child: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Up Coming Movies",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            FlatButton(
              color: Colors.transparent,
              child: Text(
                "SEE ALL",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: SeeAllMoviesPage(
                        "Up Coming Movies", 'Up Coming', _listUpComingMovie),
                  ),
                );
              },
            ),
          ],
        ),
        FutureBuilder<List<Result>>(
          future: _fetchData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                _listUpComingMovie = snapshot.data;
                return _buildUpComingMoviesListView(
                    context, _listUpComingMovie);
              } else {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    ),
  );
}

Widget _buildUpComingMoviesListView(context, List<Result> data) {
  List<Widget> list = [];
  Widget row;
  for (Result res in data) {
    row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          DateFormat.yMMMd("en_US").format(res.releaseDate),
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
    list.add(buildMovieItem(context, res, row));
  }

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: list,
    ),
  );
}
