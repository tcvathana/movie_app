import 'package:flutter/material.dart';
import '../button_add_to_watchlist.dart';
import '../button_mark_as_favorite.dart';

class MovieAccountStatesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ButtonMarkAsFavorite(),
          ButtonAddToWatchList(),
        ],
      ),
    );
  }
}
