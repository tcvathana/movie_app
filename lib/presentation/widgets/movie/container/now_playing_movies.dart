import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:movie_app/presentation/widgets/movie/movie_item_horizontal_loading_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../data/models/movie_list.dart';
import '../movie_item_play_now.dart';

class NowPlayingMovies extends StatelessWidget {
  const NowPlayingMovies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 10, top: 15, bottom: 30, right: 10),
      margin: EdgeInsets.only(top: 0),
      color: Colors.white.withOpacity(0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Now Playing Movies",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          BlocBuilder<MovieListBloc, MovieListState>(
            builder: (BuildContext context, MovieListState state) {
              if (state is MovieListLoaded) {
                return Container(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.nowPlayingMovie.results.length,
                    itemBuilder: (context, index) {
                      return MovieItemPlayNow(
                        movieResult: state.nowPlayingMovie.results[index],
                      );
                    },
                  ),
                );
              }
              return Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Container(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return MovieItemHorizontalLoadingWidget();
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
