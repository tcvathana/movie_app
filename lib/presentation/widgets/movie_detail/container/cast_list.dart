import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import '../cast_item.dart';

class CastList extends StatelessWidget {
  const CastList({Key key}) : super(key: key);

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
              "Casts",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 240,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movieDetailState.movieCredit.cast.length,
                itemBuilder: (BuildContext context, int index) {
                  return CastItem(
                    cast: movieDetailState.movieCredit.cast[index],
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
}
