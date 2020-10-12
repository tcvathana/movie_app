import 'package:flutter/material.dart';
import 'package:movie_app/presentation/pages/auth_page.dart';
import 'package:page_transition/page_transition.dart';
import '../../data/repositories/movie_repository.dart';
import '../widgets/movie/container/popular_movies.dart';
import '../widgets/movie/container/top_rated_movies.dart';
import '../widgets/movie/container/up_coming_movies.dart';
import '../widgets/movie/container/now_playing_movies.dart';
import './search_movie_page.dart';
import '../../injection_container.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieRepository movieRepository = sl<MovieRepository>();

  @override
  void initState() {
    super.initState();
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
                  child: SearchMoviePage(),
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
                  child: AuthPage(),
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
                fetchData: movieRepository.getNowPlayingMovieList(),
              ),
              PopularMovies(
                fetchData: movieRepository.getMostPopularMovieList(),
              ),
              TopRatedMovies(
                fetchData: movieRepository.getTopRatedMovieList(),
              ),
              UpComingMovies(
                fetchData: movieRepository.getUpComingMovieList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
