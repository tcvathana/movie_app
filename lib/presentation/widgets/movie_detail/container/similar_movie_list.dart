import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app/presentation/widgets/movie_detail/similar_movie_item.dart';

class SimilarMovieList extends StatelessWidget {
  const SimilarMovieList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieDetailState movieDetailState =
        context.bloc<MovieDetailBloc>().state;
    if(movieDetailState is MovieDetailLoaded) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Similar Movie",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Container(
              height: 350,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movieDetailState.movieSimilar.results.length,
                itemBuilder: (BuildContext context, int index) {
                  return SimilarMovieItem(
                    result: movieDetailState.movieSimilar.results[index],
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
    // TODO: Implement Shimmer HERE
  }
}
