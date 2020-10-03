import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_review.dart';

class ReviewItem extends StatelessWidget {
  final ResultReview result;

  const ReviewItem({Key key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _seeMoreReview = false;
    return InkWell(
      onTap: () {
        /*setState(() {
          _seeMoreReview = !_seeMoreReview;
        });*/
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 20,
          top: 20,
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              result.author,
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            _seeMoreReview
                ? Text(
                    result.content,
                    style: TextStyle(color: Colors.white),
                  )
                : Text(
                    result.content,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 8,
                    style: TextStyle(color: Colors.white),
                  ),
          ],
        ),
      ),
    );
  }
}
