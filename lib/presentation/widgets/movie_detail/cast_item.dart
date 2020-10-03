import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../config.dart';
import '../../../data/models/movie_credits.dart';

class CastItem extends StatelessWidget {
  final Cast cast;

  const CastItem({Key key, this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(right: 10),
      color: Colors.white.withOpacity(0.08),
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            cast.profilePath != null
                ? Ink.image(
                    alignment: Alignment.center,
                    image: CachedNetworkImageProvider(
                      "$IMAGE_BASE_URL/w500/${cast.profilePath}",
                    ),
                    width: 120,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 120,
                    height: 150,
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
            Container(
              width: 120,
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    cast.name,
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "as",
                    style: TextStyle(color: Colors.blue),
                  ),
                  Text(
                    cast.character,
                    style: TextStyle(color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
