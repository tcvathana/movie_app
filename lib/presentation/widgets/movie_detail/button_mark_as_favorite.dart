import 'package:flutter/material.dart';

class ButtonMarkAsFavorite extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onFavoritePress;

  const ButtonMarkAsFavorite({Key key, this.isFavorite, this.onFavoritePress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onFavoritePress();
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
            color: isFavorite == false
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
              isFavorite == false ? Icons.favorite_border : Icons.favorite,
              color: Colors.red,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              isFavorite == false ? "Mark As Favorite" : "Added to Favorite",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
