import 'package:flutter/material.dart';
import 'package:movie_app/presentation/widgets/see_more_movie/movie_list_view_widget.dart';
import 'package:page_transition/page_transition.dart';
import '../../data/models/movie_list.dart';
import './account_page.dart';

class SeeMoreMoviesPage extends StatefulWidget {
  final String title;
  final List<ResultMovie> initList;

  SeeMoreMoviesPage({
    this.title,
    this.initList,
  });

  @override
  _SeeMoreMoviesPageState createState() => _SeeMoreMoviesPageState();
}

class _SeeMoreMoviesPageState extends State<SeeMoreMoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.account_circle,
            ),
            color: Colors.blueAccent,
            tooltip: "Account Page",
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: AccountPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Container(
          color: Colors.black87,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: MovieListViewWidget(initList: widget.initList,),
        ),
      ),
    );
  }

  Future<void> onRefresh() {
    // TODO: Implement onRefresh
    print("Hello");
    return Future.value(0);
  }
}
