import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:duration/duration.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import '../../../../config.dart';

class MovieDetailWidget extends StatelessWidget {

  const MovieDetailWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieDetailState movieDetailState = context.bloc<MovieDetailBloc>().state;
    if(movieDetailState is MovieDetailLoaded) {
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
                  "$IMAGE_BASE_URL/w500${movieDetailState.movieDetail.posterPath}",
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
                                .format(movieDetailState.movieDetail.releaseDate),
                        style:
                        TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        "Runtime: " +
                            prettyDuration(
                                Duration(minutes: movieDetailState.movieDetail.runtime)),
                        style:
                        TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        "Rating: ${movieDetailState.movieDetail.voteAverage}/10",
                        style:
                        TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        movieDetailState.movieDetail.budget == 0
                            ? "Budget: N/A"
                            : "Budget: \$" +
                            NumberFormat("#,###", "en_US")
                                .format(movieDetailState.movieDetail.budget) +
                            " USD",
                        style:
                        TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        movieDetailState.movieDetail.revenue == 0
                            ? "Revenue: N/A"
                            : "Revenue: \$" +
                            NumberFormat("#,###", "en_US")
                                .format(movieDetailState.movieDetail.revenue) +
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
              itemCount: movieDetailState.movieDetail.genres.length,
              itemBuilder: (BuildContext context, int index) {
                return Chip(
                  label: Text(movieDetailState.movieDetail.genres[index].name),
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
                  movieDetailState.movieDetail.overview,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      );
    }
    // TODO: Build Shimmer HERE
    return Container();
  }
}
