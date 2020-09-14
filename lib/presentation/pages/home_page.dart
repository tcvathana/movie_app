import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './search_page.dart';
import '../../models/movie.dart';
import 'package:page_transition/page_transition.dart';
import '../../helper/uihelper.dart';

import 'movie_detail_page.dart';
import 'account_page.dart';
import '../../config.dart';

List<Result> _parseData(String input) {
  Map<String, dynamic> map = json.decode(input);
  Movie movie = Movie.fromMap(map);
  List<Result> list = movie.results;
  return list;
}

Future<List<Result>> fetchDataNowPlaying() async {
  http.Response response = await http
      .get("https://api.themoviedb.org/3/movie/now_playing?api_key=$API_KEY");
  if (response.statusCode == 200) {
    return _parseData(response.body);
  } else {
    throw Exception("Error ${response.toString()}");
  }
}

Future<List<Result>> fetchDataMostPopular() async {
  http.Response response = await http
      .get("https://api.themoviedb.org/3/movie/popular?api_key=$API_KEY");
  if (response.statusCode == 200) {
    return _parseData(response.body);
  } else {
    throw Exception("Error ${response.toString()}");
  }
}

Future<List<Result>> fetchDataTopRate() async {
  http.Response response = await http
      .get("https://api.themoviedb.org/3/movie/top_rated?api_key=$API_KEY");
  if (response.statusCode == 200) {
    return _parseData(response.body);
  } else {
    throw Exception("Error ${response.toString()}");
  }
}

Future<List<Result>> fetchDataUpComing() async {
  http.Response response = await http
      .get("https://api.themoviedb.org/3/movie/upcoming?api_key=$API_KEY");
  if (response.statusCode == 200) {
    return _parseData(response.body);
  } else {
    throw Exception("Error ${response.toString()}");
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Result>> _dataFetchedNowPlaying;
  Future<List<Result>> _dataFetchedMostPopular;
  Future<List<Result>> _dataFetchedTopRate;
  Future<List<Result>> _dataFetchedUpComing;

  @override
  void initState() {
    super.initState();
    setState(() {
      _dataFetchedNowPlaying = fetchDataNowPlaying();
      _dataFetchedMostPopular = fetchDataMostPopular();
      _dataFetchedTopRate = fetchDataTopRate();
      _dataFetchedUpComing = fetchDataUpComing();
    });
  }

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
      title: Text("Movie Trailer"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: SearchPage()));
          },
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

  _buildBody() {
    return Container(
      color: Colors.black87,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildNowPlayingMovie(),
            buildPopularMovies(context, _dataFetchedMostPopular),
            buildTopRateMovies(context, _dataFetchedTopRate),
            buildUpComingMovies(context, _dataFetchedUpComing),
          ],
        ),
      ),
    );
  }

  _buildNowPlayingMovie() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 10, top: 15, bottom: 30, right: 10),
      margin: EdgeInsets.only(top: 0),
      color: Colors.white.withOpacity(0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Movies Now Playing",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          FutureBuilder<List<Result>>(
            future: _dataFetchedNowPlaying,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return _buildPlayNowMoviesList(snapshot.data);
                } else {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                }
              } else {
                return Container(
                  height: MediaQuery.of(context).size.width * 3 / 4,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  _buildPlayNowMoviesList(List<Result> listMovies) {
    List<Widget> list = [];
    for (Result res in listMovies) {
      list.add(_buildPlayNowMovieItem(res));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list,
      ),
    );
  }

  _buildPlayNowMovieItem(Result result) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.white.withOpacity(0.15),
      child: InkWell(
        highlightColor: Colors.black26,
        splashColor: Colors.black26,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MovieDetailPage(result.id, result.title)));
        },
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                CachedNetworkImage(
                  width: MediaQuery.of(context).size.width * 80 / 100,
                  imageUrl:
                      "https://image.tmdb.org/t/p/w500${result.backdropPath}",
                  placeholder: (context, url) => Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(bottom: 10, left: 5, top: 10),
                  width: MediaQuery.of(context).size.width * 80 / 100,
                  color: Colors.white.withOpacity(0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        result.title,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        result.overview.substring(0, 40),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 15,
              right: 10,
              child: Container(
                height: 160,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: CachedNetworkImageProvider(
                        "https://image.tmdb.org/t/p/w500${result.posterPath}"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
