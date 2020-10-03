import 'package:flutter/material.dart';
import 'package:movie_app/data/repositories/movie_detail_repository.dart';
import '../../../../data/models/movie_credits.dart';
import '../cast_item.dart';

class CastList extends StatelessWidget {
  final Future<MovieCredit> getMovieCredit;

  const CastList({Key key, this.getMovieCredit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Casts",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder<MovieCredit>(
            future: getMovieCredit,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Container(
                    height: 240,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.cast.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CastItem(cast: snapshot.data.cast[index]);
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      "No Data",
                      style: TextStyle(color: Colors.white),
                    ),
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
