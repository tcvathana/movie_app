import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:movie_app/presentation/widgets/movie/movie_item_horizontal.dart';

class SearchMovieListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SearchMovieState searchState = context.bloc<SearchMovieBloc>().state;
    if (searchState is SearchMovieLoaded) {
      if (searchState.movieList.results.length == 0) {
        return Center(
          child: Text(
            "Search not found",
            style: TextStyle(color: Colors.white),
          ),
        );
      }
      return ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: searchState.movieList.results.length,
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey,
            thickness: 1,
          );
        },
        itemBuilder: (context, index) {
          return MovieItemHorizontal(
            movieResult: searchState.movieList.results[index],
          );
        },
      );
    }
    if (searchState is SearchMovieLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (searchState is SearchMovieError) {
      return Center(child: Text(searchState.error));
    }
    if (searchState is SearchMovieInitial) {
      return Center(
        child: Text(
          "Enter something",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
    return Container();
  }
}
