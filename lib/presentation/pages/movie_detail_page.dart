import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:duration/duration.dart';
import 'package:movie_app/data/data_sources/remote/movie_remote_data_source.dart';
import 'package:movie_app/data/repositories/account_repository.dart';
import 'package:movie_app/data/repositories/movie_repository.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'package:movie_app/data/models/movie_account_states.dart';
import 'package:movie_app/data/models/review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'account_page.dart';
import '../../data/models/movie_detail.dart';
import '../../data/models/movie_credits.dart';
import '../../data/models/movie_list.dart';
import '../../data/models/movie_video.dart';
import '../widgets/movie/movie_item.dart';
import '../../config.dart';

MovieDetail _parseData(String input) {
  Map<String, dynamic> map = json.decode(input);
  MovieDetail movie = MovieDetail.fromMap(map);
  return movie;
}

Future<MovieDetail> fetchData(String id) async {
  http.Response response =
      await http.get("$SERVICE_URL/movie/" + id + "?api_key=$API_KEY");
  if (response.statusCode == 200) {
    return compute(_parseData, response.body);
  } else {
    throw Exception("Error ${response.toString()}");
  }
}

//Reviews
Review _parseDataReview(String input) {
  Map<String, dynamic> map = json.decode(input);
  Review review = Review.fromJson(map);
  return review;
}

Future<Review> fetchDataReview(String id) async {
  http.Response response =
      await http.get("$SERVICE_URL/movie/$id/reviews?api_key=$API_KEY");
  if (response.statusCode == 200) {
    return compute(_parseDataReview, response.body);
  } else {
    throw Exception("Error ${response.toString()}");
  }
}

//Video
List<ResultVideo> _parseDataVideo(String input) {
  Map<String, dynamic> map = json.decode(input);
  MovieVideo movieVideo = MovieVideo.fromJson(map);
  List<ResultVideo> list = movieVideo.results;
  return list;
}

Future<List<ResultVideo>> fetchDataVideos(String movieId) async {
  http.Response response =
      await http.get("$SERVICE_URL/movie/$movieId/videos?api_key=$API_KEY");
  if (response.statusCode == 200) {
    return compute(_parseDataVideo, response.body);
  } else {
    throw Exception("Error ${response.toString()}");
  }
}

//Credits
MovieCredit _parseDataCredits(String input) {
  Map<String, dynamic> map = json.decode(input);
  MovieCredit credits = MovieCredit.fromJson(map);
  return credits;
}

Future<MovieCredit> fetchDataCredits(String id) async {
  http.Response response =
      await http.get("$SERVICE_URL/movie/$id/credits?api_key=$API_KEY");
  if (response.statusCode == 200) {
    return compute(_parseDataCredits, response.body);
  } else {
    throw Exception("Error ${response.toString()}");
  }
}

//Similar movies
MovieList _parseDataSimilar(String input) {
  Map<String, dynamic> map = json.decode(input);
  MovieList movie = MovieList.fromMap(map);
  return movie;
}

Future<MovieList> fetchDataSimilar(String id) async {
  http.Response response =
      await http.get("$SERVICE_URL/movie/$id/similar?api_key=$API_KEY");
  if (response.statusCode == 200) {
    return _parseDataSimilar(response.body);
  } else {
    throw Exception("Error ${response.toString()}");
  }
}

class MovieDetailPage extends StatefulWidget {
  int movieId;
  String movieTitle;

  MovieDetailPage(this.movieId, this.movieTitle);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  AccountRepository _accountRepository = new AccountRepository();
  final MovieRemoteDataSource remoteDataSource = new MovieRemoteDataSource();
  MovieRepository _movieRepository;

  // DATA
  Future<MovieDetail> _dataFetched;
  Future<Review> _dataFetchedReview;
  Future<List<ResultVideo>> _dataFetchedVideo;
  Future<MovieCredit> _dataFetchedCredits;
  Future<MovieList> _dataFetchedSimilar;

  String _directorName = "";
  String mySession;

  bool _seeMoreReview = false;
  bool _isFavorite = false;
  bool _isWatchlist = false;

  MovieAccountStates accountStates;

  Future<bool> markAsFavor(bool favorite) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String session = prefs.getString("session_id");
    return _accountRepository.markAsFavorite(
      sessionId: session,
      mediaId: widget.movieId,
      favorite: favorite,
    );
  }

  Future<bool> addToWatch(bool watchlist) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String session = prefs.getString("session_id");
    return _accountRepository.addToWatchlist(
      sessionId: session,
      mediaId: widget.movieId,
      watchlist: watchlist,
    );
  }

  Future<MovieAccountStates> initAccountStates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String session = prefs.getString("session_id");
    if (session == null) {
      print("session null here");
      session = null;
      return null;
    } else {
      mySession = session;
      var future = _movieRepository.getMovieAccountStates(
        sessionId: session,
        movieId: widget.movieId,
      );
      future.then((value) {
        _isFavorite = value.favorite;
        _isWatchlist = value.watchlist;
      });
      return future;
    }
  }

  Future<String> getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String session = prefs.getString("session_id");
    if (session == null) {
      return null;
    } else {
      return session;
    }
  }

  @override
  void initState() {
    super.initState();
    _movieRepository = new MovieRepository(remoteDataSource: remoteDataSource);
    setState(() {
      _dataFetched = fetchData(widget.movieId.toString());
      _dataFetchedReview = fetchDataReview(widget.movieId.toString());
      _dataFetchedVideo = fetchDataVideos(widget.movieId.toString());
      _dataFetchedCredits = fetchDataCredits(widget.movieId.toString());
      _dataFetchedSimilar = fetchDataSimilar(widget.movieId.toString());
    });
    getSession().then((value) => mySession = value);
    initAccountStates().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    getSession().then((value) => mySession = value);
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(widget.movieTitle.toString()),
      backgroundColor: Colors.black87,
      actions: <Widget>[
        mySession == null
            ? IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        alignment: Alignment.center,
                        duration: Duration(milliseconds: 300),
                        child: AccountPage(),
                      ));
                },
                icon: Icon(Icons.account_circle),
              )
            : IconButton(
                icon: _isFavorite == false
                    ? Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                onPressed: () {
                  setState(() {
                    markAsFavor(!_isFavorite);
                    initAccountStates()
                        .then((value) => _isFavorite = value.favorite);
                  });
                  if (_isFavorite == true) {
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text("Video Added to Favorite List"),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 1),
                    ));
                  } else {
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text("Video removed from Favorite List"),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 1),
                    ));
                  }
                },
              ),
      ],
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 30),
        color: Colors.black87,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildMovieInfo(),
            Divider(
              color: Colors.white.withOpacity(0.8),
            ),
            mySession == null
                ? Container()
                : InkWell(
                    onTap: () {
                      setState(() {
                        addToWatch(!_isWatchlist);
                        initAccountStates()
                            .then((value) => _isWatchlist = value.watchlist);
                      });
                      if (_isFavorite == true) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text("Video Added to Watchlist"),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 1),
                        ));
                      } else {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text("Video removed from Watchlist"),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 1),
                        ));
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                      decoration: BoxDecoration(
                          color: _isWatchlist == false
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
                            _isWatchlist == false ? Icons.add : Icons.done,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            _isWatchlist == false
                                ? "Add to WatchList"
                                : "Added to Watchlist",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
            Divider(
              color: Colors.white.withOpacity(0.8),
            ),
            _buildReviews(widget.movieId.toString()),
            Divider(
              color: Colors.white.withOpacity(0.8),
            ),
            _buildVideo(),
            Divider(
              color: Colors.white.withOpacity(0.8),
            ),
            _buildCast(),
            Divider(
              color: Colors.white.withOpacity(0.8),
            ),
            _buildSimilarMovie(),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieInfo() {
    return FutureBuilder<MovieDetail>(
      future: _dataFetched,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return _buildMovieInfoItem(snapshot.data);
          } else {
            return Center(
              child: Text(
                "Data Not available",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
        } else {
          return _buildMovieInfoItemLoading();
        }
      },
    );
  }

  Widget _buildMovieInfoItem(MovieDetail movie) {
    String genres = "";
    for (Genre gen in movie.genres) {
      genres += "${gen.name}, ";
    }
    genres = genres.substring(0, genres.length - 2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CachedNetworkImage(
                height: 240,
                width: 160,
                imageUrl: "$IMAGE_BASE_URL/w500${movie.posterPath}",
                placeholder: (context, url) => Container(
                  width: 120,
                  height: 180,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Container(
                height: 180,
                margin: EdgeInsets.only(left: 15),
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Director:$_directorName",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      "Release: " +
                          DateFormat.yMMMd().format(movie.releaseDate),
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      "Runtime: " +
                          printDuration(Duration(minutes: movie.runtime)),
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      "Rating: ${movie.voteAverage}/10",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      movie.budget == 0
                          ? "Budget: N/A"
                          : "Budget: \$" +
                              NumberFormat("#,###", "en_US")
                                  .format(movie.budget) +
                              " USD",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      movie.revenue == 0
                          ? "Revenue: N/A"
                          : "Revenue: \$" +
                              NumberFormat("#,###", "en_US")
                                  .format(movie.revenue) +
                              " USD",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "Genres: " + genres,
            style: TextStyle(color: Colors.white),
          ),
        ),
        Divider(
          color: Colors.white.withOpacity(0.8),
        ),
        _buildOverview(movie),
      ],
    );
  }

  Widget _buildMovieInfoItemLoading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 180,
                width: 120,
                color: Colors.white,
              ),
              Container(
                height: 180,
                margin: EdgeInsets.only(left: 15),
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SkeletonAnimation(
                      child: Container(
                        height: 10,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SkeletonAnimation(
                      child: Container(
                        height: 8,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: 8,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                    ),
                    SkeletonAnimation(
                      child: Container(
                        height: 8,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: 8,
                      width: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      height: 8,
                      width: 170,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
            height: 8,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
          ),
        ),
        Divider(
          color: Colors.white.withOpacity(0.8),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Overview",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOverview(MovieDetail movie) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Overview",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            movie.overview,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildReviews(String id) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Reviews",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          FutureBuilder<Review>(
            future: _dataFetchedReview,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return _buildReviewList(snapshot.data);
                } else {
                  return Container(
                    child: Center(
                      child: Text(
                        "No Reviews",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  );
                }
              } else {
                return _buildReviewListLoading();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReviewList(Review review) {
    List<Widget> list = [];
    for (ResultReview result in review.results) {
      list.add(_buildReviewItem(result));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: list.isNotEmpty
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list,
            )
          : Text(
              "No data Available",
              style: TextStyle(color: Colors.grey),
            ),
    );
  }

  Widget _buildReviewListLoading() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              right: 20,
              top: 20,
            ),
            width: MediaQuery.of(context).size.width - 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                ),
                Container(
                  height: 100,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              right: 20,
              top: 20,
            ),
            width: MediaQuery.of(context).size.width - 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                ),
                Container(
                  height: 100,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(ResultReview result) {
    return InkWell(
      onTap: () {
        setState(() {
          _seeMoreReview = !_seeMoreReview;
        });
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 20,
          top: 20,
        ),
        width: MediaQuery.of(context).size.width - 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              result.author,
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            _seeMoreReview
                ? Text(
                    result.content,
                    style: TextStyle(color: Colors.white),
                  )
                : Text(
                    result.content,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 8,
                    style: TextStyle(color: Colors.white),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideo() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Videos",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          FutureBuilder<List<ResultVideo>>(
            future: _dataFetchedVideo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return _buildVideoList(snapshot.data);
                } else {
                  return Text("Has no Video");
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVideoList(List<ResultVideo> results) {
    List<Widget> list = [];
    for (ResultVideo res in results) {
      list.add(_buildVideoItem(res));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list,
      ),
    );
  }

  _launchURL(String key) async {
    String url = 'https://www.youtube.com/watch?v=$key';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildVideoItem(ResultVideo res) {
    return InkWell(
      onTap: () {
        _launchURL(res.key);
      },
      child: Container(
        margin: EdgeInsets.only(right: 25, top: 10),
        width: 320,
        height: 180,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                "https://img.youtube.com/vi/${res.key}/sddefault.jpg",
              ),
              fit: BoxFit.cover),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.play_arrow,
          color: Colors.white,
          size: 60,
        ),
      ),
    );
  }

  Widget _buildCast() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Casts",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder<MovieCredit>(
            future: _dataFetchedCredits,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return _buildCastList(snapshot.data);
                } else {
                  return Center(
                    child: Text(
                      "No Data",
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
        ],
      ),
    );
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Widget _buildCastList(MovieCredit credit) {
    List<Widget> list = [];
    for (Cast cast in credit.cast.sublist(0, 5)) {
      list.add(_buildCastItem(cast));
    }
    for (Crew crew in credit.crew) {
      if (crew.job.toLowerCase() == "director") {
        _directorName = crew.name;
      }
    }

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () async {
        setState(() {});
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list,
        ),
      ),
    );
  }

  Widget _buildCastItem(Cast cast) {
    return Card(
      margin: EdgeInsets.only(right: 10),
      color: Colors.white.withOpacity(0.08),
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            cast.profilePath != null
                ? Ink.image(
                    alignment: Alignment.center,
                    image: CachedNetworkImageProvider(
                      "$IMAGE_BASE_URL/w500/${cast.profilePath}",
                    ),
                    width: 120,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 120,
                    height: 150,
                    child: Center(
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
            Container(
              width: 120,
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    cast.name,
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "as",
                    style: TextStyle(color: Colors.blue),
                  ),
                  Text(
                    cast.character,
                    style: TextStyle(color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimilarMovie() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Similar Movie",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          FutureBuilder<MovieList>(
            future: _dataFetchedSimilar,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return _buildSimilarMovieList(snapshot.data);
                } else {
                  return Center(
                    child: Text("Not Available"),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarMovieList(MovieList movie) {
    List<Widget> list = [];
    for (MovieResult res in movie.results) {
      Row row = Row(
        children: <Widget>[
          Icon(
            Icons.star,
            size: 15,
            color: Colors.yellow,
          ),
          Text(
            "${res.voteAverage}/10",
            style: TextStyle(color: Colors.white),
          ),
        ],
      );
      list.add(MovieItem(result: res, info: row));
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: list.isNotEmpty
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list,
            )
          : Text(
              "No data Available",
              style: TextStyle(color: Colors.grey),
            ),
    );
  }
}
