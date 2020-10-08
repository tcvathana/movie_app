import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/account/favorite_movie/favorite_movie_bloc.dart';
import 'package:movie_app/presentation/widgets/movie/movie_item_horizontal.dart';

class FavoriteListMovieContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
      builder: (context, state) {
        if (state is FavoriteMovieLoadedState) {
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
        if (state is FavoriteMovieLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is FavoriteMovieErrorState) {
          return Center(
            child: Text(
              state.error,
              style: TextStyle(color: Colors.red),
            ),
          );
        }
        return Container();
      },
    );
  }
}
