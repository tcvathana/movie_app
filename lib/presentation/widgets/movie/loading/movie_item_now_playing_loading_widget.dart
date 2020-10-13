import 'package:flutter/material.dart';

class MovieItemNowPlayingLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.white.withOpacity(0.15),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: 300,
                height: 170,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(bottom: 10, left: 5, top: 10),
                width: 300,
                color: Colors.white.withOpacity(0.08),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Movie Title",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Movie Overview",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              height: 160,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
