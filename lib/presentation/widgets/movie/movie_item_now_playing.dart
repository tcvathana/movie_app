import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/presentation/pages/movie_detail_page.dart';
import '../../../data/models/movie_list.dart';
import '../../../config.dart';

class MovieItemNowPlaying extends StatelessWidget {
  final ResultMovie movieResult;

  const MovieItemNowPlaying({Key key, @required this.movieResult})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              builder: (context) => MovieDetailPage(
                movieId: movieResult.id,
              ),
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                CachedNetworkImage(
                  width: 300,
                  height: 170,
                  imageUrl: "$IMAGE_BASE_URL/w300${movieResult.backdropPath}",
                  placeholder: (context, url) => Container(
                    child: Container(
                      height: 170,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(bottom: 10, left: 5, top: 10),
                  width: 300,
                  color: Colors.white.withOpacity(0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        movieResult.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        movieResult.overview.substring(0, 40),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                height: 160,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: CachedNetworkImageProvider(
                        "$IMAGE_BASE_URL/w500${movieResult.posterPath}"),
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
