import 'package:flutter/material.dart';

class MovieItemLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.15),
      child: Column(
        children: <Widget>[
          Container(
              height: 240,
              width: 160,
              color: Colors.white.withOpacity(0.3),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 15),
            width: 160,
            height: 100,
          ),
        ],
      ),
    );
  }
}
