import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/account/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movie_app/presentation/widgets/movie/movie_item_horizontal.dart';

class WatchlistMovieContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
      builder: (context, state) {
        if (state is WatchlistMovieLoadedState) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 180,
            child: ListView.separated(
              itemCount: state.movieList.results.length,
              itemBuilder: (context, index) {
                return MovieItemHorizontal(
                  movieResult: state.movieList.results[index],
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          );
        }
        if (state is WatchlistMovieErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
