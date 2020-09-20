import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../pages/see_all_movie_page.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../data/models/movie_list.dart';
import '../movie_item_popular.dart';

class PopularMovies extends StatelessWidget {
  final Future<MovieList> fetchData;

  const PopularMovies({Key key, @required this.fetchData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MovieResult> _listPopularMovie = [];
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 10, top: 15, bottom: 30),
      margin: EdgeInsets.only(top: 20),
      color: Colors.white.withOpacity(0.08),
      child: Column(
        children: <Widget>[
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
                  "SEE ALL",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: SeeAllMoviesPage(
                          "Most Poppular Movie", "Popularity", _listPopularMovie),
                    ),
                  );
                },
              ),
            ],
          ),
          FutureBuilder<MovieList>(
            future: fetchData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  _listPopularMovie = snapshot.data.results;
                  return Container(
                    height: 350,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _listPopularMovie.length,
                      itemBuilder: (context, index) {
                        return MovieItemPopular(
                          result: _listPopularMovie[index],
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Text("Error: ${snapshot.error}"),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
