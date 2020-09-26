import 'package:flutter/material.dart';
import 'package:movie_app/presentation/pages/login_page.dart';
import 'package:page_transition/page_transition.dart';

import 'account_page.dart';
import './search_page.dart';
import '../widgets/movie/container/popular_movies.dart';
import '../widgets/movie/container/top_rated_movies.dart';
import '../widgets/movie/container/up_coming_movies.dart';
import '../widgets/movie/container/now_playing_movies.dart';
import '../../data/models/movie_list.dart';
import '../../data/repositories/movie_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieRepository movieRepository = new MovieRepository();

  Future<MovieList> _dataFetchedNowPlaying;
  Future<MovieList> _dataFetchedMostPopular;
  Future<MovieList> _dataFetchedTopRated;
  Future<MovieList> _dataFetchedUpComing;

  @override
  void initState() {
    super.initState();
    setState(() {
      _dataFetchedNowPlaying = movieRepository.getNowPlayingMovieList();
      _dataFetchedMostPopular = movieRepository.getMostPopularMovieList();
      _dataFetchedTopRated = movieRepository.getTopRatedMovieList();
      _dataFetchedUpComing = movieRepository.getUpComingMovieList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Movie Trailer"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: SearchPage(),
                ),
              );
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
                  // child: AccountPage(),
                  child: LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black87,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              NowPlayingMovies(
                fetchData: _dataFetchedNowPlaying,
              ),
              PopularMovies(
                fetchData: _dataFetchedMostPopular,
              ),
              TopRatedMovies(
                fetchData: _dataFetchedTopRated,
              ),
              UpComingMovies(
                fetchData: _dataFetchedUpComing,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
