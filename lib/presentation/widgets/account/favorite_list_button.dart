import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../pages/favorite_list_page.dart';

class FavoriteListButton extends StatelessWidget {
  const FavoriteListButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: FavoriteListPage(),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        padding: EdgeInsets.all(15),
        color: Colors.white.withOpacity(0.1),
        child: Text(
          "Favourite List",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
