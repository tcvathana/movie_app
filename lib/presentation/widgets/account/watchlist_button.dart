import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../pages/watchlist_page.dart';

class WatchlistButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: WatchlistPage(),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        padding: EdgeInsets.all(15),
        color: Colors.white.withOpacity(0.1),
        child: Text(
          "Watchlist",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
