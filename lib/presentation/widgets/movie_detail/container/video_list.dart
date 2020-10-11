import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/models/movie_video.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import '../video_item.dart';

class VideoList extends StatelessWidget {

  const VideoList({Key key}) : super(key: key);

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
              "Videos",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Container(
              height: 190,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movieDetailState.movieVideo.results.length,
                itemBuilder: (BuildContext context, int index) {
                  return VideoItem(
                    result: movieDetailState.movieVideo.results[index],
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
