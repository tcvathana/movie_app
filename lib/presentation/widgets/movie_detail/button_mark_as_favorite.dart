import 'package:flutter/material.dart';

class ButtonMarkAsFavorite extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onFavoritePress;

  const ButtonMarkAsFavorite({Key key, this.isFavorite, this.onFavoritePress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: isFavorite == false
          ? Icon(
              Icons.favorite_border,
              color: Colors.white,
            )
          : Icon(
              Icons.favorite,
              color: Colors.red,
            ),
      onPressed: () {
        onFavoritePress();
      },
    );
  }
}
