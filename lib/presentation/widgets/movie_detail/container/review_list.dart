import 'package:flutter/material.dart';
import '../../../../data/models/movie_review.dart';
import '../review_item.dart';

class ReviewList extends StatelessWidget {
  final Future<MovieReview> getMovieReview;

  const ReviewList({Key key, @required this.getMovieReview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Reviews",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          FutureBuilder<MovieReview>(
            future: getMovieReview,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.results.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ReviewItem(
                          result: snapshot.data.results[index],
                        );
                      },
                    ),
                  );
                } else {
                  return Container(
                    child: Center(
                      child: Text(
                        "No Reviews",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  );
                }
              } else {
                //return _buildReviewListLoading();
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
/*Widget _buildReviewListLoading() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              right: 20,
              top: 20,
            ),
            width: MediaQuery.of(context).size.width - 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                ),
                Container(
                  height: 100,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              right: 20,
              top: 20,
            ),
            width: MediaQuery.of(context).size.width - 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                ),
                Container(
                  height: 100,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }*/
}
