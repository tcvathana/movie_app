import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_video.dart';

import '../video_item.dart';

class VideoList extends StatelessWidget {
  final Future<MovieVideo> getMovieVideo;

  const VideoList({Key key, this.getMovieVideo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Videos",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          FutureBuilder<MovieVideo>(
            future: getMovieVideo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Container(
                    height: 190,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.results.length,
                      itemBuilder: (BuildContext context, int index) {
                        return VideoItem(
                          result: snapshot.data.results[index],
                        );
                      },
                    ),
                  );
                } else {
                  return Text("Has no Video");
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
}
