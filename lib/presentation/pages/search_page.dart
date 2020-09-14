import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../models/movie.dart';
import './movie_detail_page.dart';

import '../../config.dart';

Movie _parseData(String input) {
  Map<String, dynamic> map = json.decode(input);
  Movie movie = Movie.fromMap(map);
  return movie;
}

Future<Movie> fetchData(String query) async {
  http.Response response = await http.get(
      "https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&query=$query");
  if (response.statusCode == 200) {
    return compute(_parseData, response.body);
  } else {
    throw Exception("Error ${response.toString()}");
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<Movie> _dataFetched;
  String _query;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
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
            setState(() {
              _dataFetched = fetchData(text);
            });
          },
        ),
      ),
    );
  }

  _buildBody() {
    return Container(
      color: Colors.black87,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: _dataFetched == null
          ? Container()
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: FutureBuilder<Movie>(
                future: _dataFetched,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return _buildList(snapshot.data);
                    } else {
                      return Center(
                        child: Text(
                          "Not Available",
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

  _buildList(Movie movie) {
    List<Widget> list = [];
    for (Result res in movie.results) {
      list.add(_buildItem(res));
    }
    return Column(
      children: list,
    );
  }

  _buildItem(Result res) {
    return Card(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailPage(res.id, res.title),
            ),
          );
        },
        highlightColor: Colors.black26,
        splashColor: Colors.black26,
        child: Row(
          children: <Widget>[
            Ink.image(
              image: NetworkImage(
                "https://image.tmdb.org/t/p/w500${res.posterPath}",
              ),
              width: 150,
              height: 200,
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width - 150 - 5 - 5,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    res.title,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    DateFormat.yMMMd().format(res.releaseDate),
                    style: TextStyle(color: Colors.grey),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Text(
                    res.overview,
                    style: TextStyle(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                  Text(
                    "Rate: ${res.voteAverage.toString()}/10",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
