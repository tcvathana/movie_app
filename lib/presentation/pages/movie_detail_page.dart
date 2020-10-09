import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/repositories/account_repository.dart';
import 'package:movie_app/data/repositories/movie_detail_repository.dart';
import 'package:movie_app/injection_container.dart';
import 'package:movie_app/presentation/widgets/movie_detail/button_add_to_watchlist.dart';
import 'package:movie_app/presentation/widgets/movie_detail/button_mark_as_favorite.dart';
import 'package:movie_app/presentation/widgets/movie_detail/container/cast_list.dart';
import 'package:movie_app/presentation/widgets/movie_detail/container/movie_detail_widget.dart';
import 'package:movie_app/presentation/widgets/movie_detail/container/review_list.dart';
import 'package:movie_app/presentation/widgets/movie_detail/container/similar_movie_list.dart';
import 'package:movie_app/presentation/widgets/movie_detail/container/video_list.dart';


class MovieDetailPage extends StatelessWidget {
  final int movieId;
  final String movieTitle;

  MovieDetailPage(this.movieId, this.movieTitle);

  final AccountRepository accountRepository = new AccountRepository();
  final MovieDetailRepository movieDetailRepository =
      sl<MovieDetailRepository>();

  bool _isFavorite = true;
  bool _isWatchlist = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(movieTitle.toString()),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          ButtonMarkAsFavorite(
            isFavorite: _isFavorite,
            onFavoritePress: onFavoritePress,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 30),
          color: Colors.black87,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MovieDetailWidget(
                getMovieDetail: movieDetailRepository.getMovieDetail(
                  movieId: movieId.toString(),
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(0.8),
              ),
              ButtonAddToWatchList(
                isWatchlist: _isWatchlist,
                onAddToWatchList: onAddToWatchList,
              ),
              Divider(
                color: Colors.white.withOpacity(0.8),
              ),
              ReviewList(
                getMovieReview: movieDetailRepository.getMovieReview(
                  movieId: movieId.toString(),
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(0.8),
              ),
              VideoList(
                getMovieVideo: movieDetailRepository.getMovieVideo(
                  movieId: movieId.toString(),
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(0.8),
              ),
              CastList(
                getMovieCredit: movieDetailRepository.getMovieCredit(
                  movieId: movieId.toString(),
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(0.8),
              ),
              SimilarMovieList(
                getMovieSimilar: movieDetailRepository.getMovieSimilar(
                  movieId: movieId.toString(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onFavoritePress() {
    if (_isFavorite == true) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Video Added to Favorite List"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ));
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Video removed from Favorite List"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ));
    }
  }

  void onAddToWatchList() {
    if (_isWatchlist == true) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Video Added to Watchlist"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ));
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Video removed from Watchlist"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ));
    }
  }
}
