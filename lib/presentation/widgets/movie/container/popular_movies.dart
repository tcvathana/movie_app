import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:movie_app/presentation/widgets/movie/loading/movie_item_loading_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../pages/see_all_movie_page.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../data/models/movie_list.dart';
import '../movie_item_popular.dart';

class PopularMovies extends StatelessWidget {
  const PopularMovies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 10, top: 15, bottom: 30),
      margin: EdgeInsets.only(top: 20),
      color: Colors.white.withOpacity(0.1),
      child: BlocBuilder<MovieListBloc, MovieListState>(
        builder: (BuildContext context, MovieListState state) {
          if (state is MovieListLoaded) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Most Popular Movies",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    FlatButton(
                      color: Colors.transparent,
                      child: Text(
                        "SEE MORE",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: SeeMoreMoviesPage(
                              title: "Most Popular Movie",
                              sortedBy:"Popularity",
                              movieList: state.popularMovie,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Container(
                  height: 350,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.popularMovie.results.length,
                    itemBuilder: (context, index) {
                      return MovieItemPopular(
                        result: state.popularMovie.results[index],
                      );
                    },
                  ),
                ),
              ],
            );
          }
          // Otherwise, Loading
          return Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.grey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Most Popular Movies",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    FlatButton(
                      color: Colors.transparent,
                      child: Text(
                        "SEE MORE",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () => null,
                    ),
                  ],
                ),
                Container(
                  height: 350,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return MovieItemLoadingWidget();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
