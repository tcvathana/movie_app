import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import '../review_item.dart';

class ReviewListWidget extends StatelessWidget {
  const ReviewListWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieDetailState movieDetailState =
        context.bloc<MovieDetailBloc>().state;
    if (movieDetailState is MovieDetailLoaded) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Reviews",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movieDetailState.movieReview.results.length,
                itemBuilder: (BuildContext context, int index) {
                  return ReviewItem(
                    result: movieDetailState.movieReview.results[index],
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
    // TODO: Implement Shimmer HERE
    return Container();
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
