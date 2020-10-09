import 'package:flutter/material.dart';

class ButtonAddToWatchList extends StatelessWidget {
  final bool isWatchlist;
  final VoidCallback onAddToWatchList;

  const ButtonAddToWatchList({
    Key key,
    @required this.isWatchlist,
    @required this.onAddToWatchList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onAddToWatchList();
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
            color: isWatchlist == false
                ? Colors.white.withOpacity(0.3)
                : Colors.white.withOpacity(0.0),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 0.5,
            )),
        child: Row(
          children: <Widget>[
            Icon(
              isWatchlist == false ? Icons.add : Icons.done,
              color: Colors.white,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              isWatchlist == false ? "Add to WatchList" : "Added to Watchlist",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
