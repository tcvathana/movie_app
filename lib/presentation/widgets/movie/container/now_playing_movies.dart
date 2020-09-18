import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../../data/models/movie_list.dart';
import '../movie_item_play_now.dart';

class NowPlayingMovies extends StatelessWidget {
  final Future<MovieList> fetchData;

  const NowPlayingMovies({Key key, @required this.fetchData}) : super(key: key);

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
          FutureBuilder<MovieList>(
            future: fetchData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Container(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.results.length,
                      itemBuilder: (context, index) {
                        return MovieItemPlayNow(
                          movieResult: snapshot.data.results[index],
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
                return Container(
                  height: MediaQuery.of(context).size.width * 3 / 4,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
