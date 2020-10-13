import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_list.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/presentation/pages/movie_detail_page.dart';
import 'package:page_transition/page_transition.dart';
import '../../../config.dart';

class MovieItem extends StatelessWidget {
  final ResultMovie result;
  final Widget info;

  const MovieItem({Key key, @required this.result, @required this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.15),
      child: InkWell(
        highlightColor: Colors.black26,
        splashColor: Colors.black26,
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: MovieDetailPage(
                movieId: result.id,
              ),
            ),
          );
        },
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                CachedNetworkImage(
                  height: 240,
                  width: 160,
                  imageUrl: "$IMAGE_BASE_URL/w185${result.posterPath}",
                  placeholder: (context, url) => Container(
                    child: Container(
                      height: 240,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 15),
              width: 160,
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    result.title,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  this.info
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
