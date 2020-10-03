import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../data/models/movie_list.dart';
import 'movie_item.dart';

class MovieItemTopRated extends StatelessWidget {
  final ResultMovie result;

  const MovieItemTopRated({Key key, @required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MovieItem(
      result: result,
      info: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            result.voteCount.toString(),
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
                result.voteAverage.toString(),
                style: TextStyle(color: Colors.amber, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
