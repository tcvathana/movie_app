import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../data/models/movie_list.dart';
import 'movie_item.dart';

class MovieItemPopular extends StatelessWidget {
  final MovieResult result;

  const MovieItemPopular({Key key, @required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MovieItem(
      result: result,
      info: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Popularity: \n${result.popularity}",
            style: TextStyle(color: Colors.amber, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
