import 'package:flutter/material.dart';
import 'package:movie_app/data/repositories/search_repository.dart';
import '../widgets/movie/movie_item_horizontal.dart';
import '../../data/models/movie_list.dart';
import '../../injection_container.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchRepository searchRepository = sl<SearchRepository>();
  Future<MovieList> _dataFetched;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(color: Colors.white),
            autofocus: true,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
            onSubmitted: (text) {
              onSearch(text);
            },
          ),
        ),
      ),
      body: Container(
        color: Colors.black87,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: FutureBuilder<MovieList>(
          future: _dataFetched,
          builder: (context, snapshot) {
            if (_dataFetched == null) {
              return Center(
                child: Text(
                  "Enter something",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.results.length,
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey,
                      thickness: 1,
                    );
                  },
                  itemBuilder: (context, index) {
                    return MovieItemHorizontal(
                      movieResult: snapshot.data.results[index],
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(
                    "No result",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  void onSearch(String text) {
    setState(() {
      _dataFetched = searchRepository.getSearchMovie(query: text);
    });
  }
}
