import 'package:flutter/material.dart';
import 'package:movie_app/data/data_sources/remote/movie_remote_data_source.dart';
import 'package:movie_app/data/models/movie_list.dart';
import 'package:movie_app/presentation/widgets/movie/movie_item_horizontal.dart';

class MovieListViewWidget extends StatefulWidget {
  final List<ResultMovie> initList;

  MovieListViewWidget({Key key, this.initList}) : super(key: key);

  @override
  _MovieListViewWidgetState createState() => _MovieListViewWidgetState();
}

class _MovieListViewWidgetState extends State<MovieListViewWidget> {
  MovieRemoteDataSource remoteDataSource = MovieRemoteDataSource();
  int _currentPage = 1;
  List<ResultMovie> _movieResults = [];
  ScrollController _scroller = ScrollController();

  Future<List<ResultMovie>> fetchMore() async {
    List<ResultMovie> _list = [];
    /*await Future.delayed(Duration(seconds: 1), () {
      for (int i = 0; i < 3; i++) {
        _list.add(widget.initList[0]);
      }
    });*/
    await remoteDataSource.fetchMostPopularMovieList(
      page: _currentPage,
    ).then((value) {
      _list.addAll(value.results);
    });
    _currentPage++;
    return _list;
  }

  _scrollLister() {
    if (_scroller.offset >= _scroller.position.maxScrollExtent &&
        !_scroller.position.outOfRange) {
      print("At the bottom scroller");
      fetchMore().then((value) {
        _movieResults.addAll(value);
        setState(() {});
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scroller.addListener(_scrollLister);
    _movieResults = widget.initList;
    _currentPage++;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        controller: _scroller,
        padding: EdgeInsets.only(top: 10, bottom: 40),
        itemCount: _movieResults.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.white.withOpacity(0.8),
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return MovieItemHorizontal(
            movieResult: _movieResults[index],
          );
        },
      ),
    );
  }
}
