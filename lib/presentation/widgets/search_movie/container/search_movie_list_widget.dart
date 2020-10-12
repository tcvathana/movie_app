import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/search/search_bloc.dart';
import 'package:movie_app/presentation/widgets/movie/movie_item_horizontal.dart';

class SearchMovieListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SearchState searchState = context.bloc<SearchBloc>().state;
    if (searchState is SearchLoaded) {
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
    if (searchState is SearchLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (searchState is SearchError) {
      return Center(child: Text(searchState.error));
    }
    if (searchState is SearchInitial) {
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
