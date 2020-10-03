import 'package:flutter/material.dart';
import '../../../data/models/movie_list.dart';
import '../movie/movie_item.dart';

class SimilarMovieItem extends StatelessWidget {
  final ResultMovie result;

  const SimilarMovieItem({Key key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MovieItem(
      result: result,
      info: Row(
        children: <Widget>[
          Icon(
            Icons.star,
            size: 15,
            color: Colors.yellow,
          ),
          Text(
            "${result.voteAverage}/10",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
