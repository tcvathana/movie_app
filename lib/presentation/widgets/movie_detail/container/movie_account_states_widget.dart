import 'package:flutter/material.dart';
import '../button_add_to_watchlist.dart';
import '../button_mark_as_favorite.dart';

class MovieAccountStatesWidget extends StatelessWidget {
  bool _isFavorite = true;
  bool _isWatchlist = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ButtonMarkAsFavorite(
            isFavorite: _isFavorite,
            onFavoritePress: onFavoritePress,
          ),
          ButtonAddToWatchList(
            isWatchlist: _isWatchlist,
            onAddToWatchList: onAddToWatchList,
          ),
        ],
      ),
    );
  }

  void onFavoritePress() {
    if (_isFavorite == true) {
      // TODO: Implement SnackBar
      print("Success");
    } else {
      // TODO: Implement SnackBar
      print("Removed");
    }
  }

  void onAddToWatchList() {
    if (_isWatchlist == true) {
      // TODO: Implement SnackBar
      print("Success");
    } else {
      // TODO: Implement SnackBar
      print("Removed");
    }
  }
}
