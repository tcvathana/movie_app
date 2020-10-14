import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_list.dart';
import 'package:movie_app/presentation/widgets/movie/movie_item_horizontal.dart';

class MovieListViewWidget extends StatefulWidget {
  MovieList movieList;

  MovieListViewWidget({Key key, this.movieList}) : super(key: key);

  @override
  _MovieListViewWidgetState createState() => _MovieListViewWidgetState();
}

class _MovieListViewWidgetState extends State<MovieListViewWidget> {
  List<ResultMovie> _movieResults = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(bottom: 40),
        itemCount: _movieResults.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.white.withOpacity(0.8),
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return MovieItemHorizontal(
            movieResult: _movieResults[index],
          );
        },
      ),
    );
  }
}
