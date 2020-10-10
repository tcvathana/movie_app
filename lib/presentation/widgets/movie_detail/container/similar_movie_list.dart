import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_list.dart';
import 'package:movie_app/presentation/widgets/movie_detail/similar_movie_item.dart';

class SimilarMovieList extends StatelessWidget {
  final Future<MovieList> getMovieSimilar;

  const SimilarMovieList({Key key, this.getMovieSimilar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Similar Movie",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          FutureBuilder<MovieList>(
            future: getMovieSimilar,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Container(
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.results.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SimilarMovieItem(
                          result: snapshot.data.results[index],
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Text("Not Available"),
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
