import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:page_transition/page_transition.dart';
import '../../../pages/see_all_movie_page.dart';
import '../../../../data/models/movie_list.dart';
import '../movie_item_top_rated.dart';

class TopRatedMovies extends StatelessWidget {
  final Future<MovieList> fetchData;

  const TopRatedMovies({Key key, @required this.fetchData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MovieResult> _listTopRatedMovie = [];
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
                "Top Rated Movies",
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
                        "Top Rated Movie",
                        'Top Rate',
                        _listTopRatedMovie,
                      ),
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
                  _listTopRatedMovie = snapshot.data.results;
                  return Container(
                    height: 350,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return MovieItemTopRated(
                          result: _listTopRatedMovie[index],
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
