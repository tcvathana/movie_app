import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:duration/duration.dart';
import 'package:intl/intl.dart';
import '../../../../config.dart';
import '../../../../data/models/movie_detail.dart';

class MovieDetailWidget extends StatelessWidget {
  final Future<MovieDetail> getMovieDetail;

  const MovieDetailWidget({Key key, this.getMovieDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieDetail>(
      future: getMovieDetail,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            //return _buildMovieInfoItem(snapshot.data);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CachedNetworkImage(
                        height: 240,
                        width: 160,
                        imageUrl:
                            "$IMAGE_BASE_URL/w500${snapshot.data.posterPath}",
                        placeholder: (context, url) => Container(
                          width: 120,
                          height: 180,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Container(
                        height: 180,
                        margin: EdgeInsets.only(left: 15),
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Release: " +
                                  DateFormat.yMMMd()
                                      .format(snapshot.data.releaseDate),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            Text(
                              "Runtime: " +
                                  prettyDuration(
                                      Duration(minutes: snapshot.data.runtime)),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            Text(
                              "Rating: ${snapshot.data.voteAverage}/10",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            Text(
                              snapshot.data.budget == 0
                                  ? "Budget: N/A"
                                  : "Budget: \$" +
                                      NumberFormat("#,###", "en_US")
                                          .format(snapshot.data.budget) +
                                      " USD",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            Text(
                              snapshot.data.revenue == 0
                                  ? "Revenue: N/A"
                                  : "Revenue: \$" +
                                      NumberFormat("#,###", "en_US")
                                          .format(snapshot.data.revenue) +
                                      " USD",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.genres.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Chip(
                        label: Text(snapshot.data.genres[index].name),
                        backgroundColor: Colors.black.withOpacity(0.8),
                        labelStyle: TextStyle(color: Colors.blue),
                      );
                    },
                  ),
                ),
                Divider(
                  color: Colors.white.withOpacity(0.8),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Overview",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data.overview,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text(
                "Data Not available",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
