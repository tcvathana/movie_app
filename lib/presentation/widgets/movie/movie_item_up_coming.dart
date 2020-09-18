import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

import '../../../data/models/movie_list.dart';
import 'movie_item.dart';

class MovieItemUpComing extends StatelessWidget {
  final MovieResult result;

  const MovieItemUpComing({Key key, @required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MovieItem(
      result: result,
      info: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            DateFormat.yMMMd("en_US").format(result.releaseDate),
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
