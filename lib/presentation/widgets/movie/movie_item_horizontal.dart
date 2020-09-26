import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import '../../../config.dart';
import '../../../data/models/movie_list.dart';
import '../../pages/movie_detail_page.dart';

class MovieItemHorizontal extends StatelessWidget {
  final MovieResult movieResult;

  const MovieItemHorizontal({Key key, this.movieResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: MovieDetailPage(movieResult.id, movieResult.title),
            ),
          );
        },
        child: Row(
          children: <Widget>[
            Container(
              width: 100,
              child: CachedNetworkImage(
                imageUrl: "$IMAGE_BASE_URL/w500${movieResult.posterPath}",
              ),
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width - 100 - 10 - 10,
              padding: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    movieResult.title,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    DateFormat.yMMMd().format(movieResult.releaseDate),
                    style: TextStyle(color: Colors.grey),
                  ),
                  Divider(
                    color: Colors.grey.withOpacity(0.8),
                  ),
                  Expanded(
                    child: Text(
                      movieResult.overview,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 14,
                        ),
                        Text(
                          movieResult.voteAverage.toString(),
                          style: TextStyle(color: Colors.amber, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
