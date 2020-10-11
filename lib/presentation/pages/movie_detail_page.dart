import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_favorite_status/movie_favorite_status_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_watchlist_status/movie_watchlist_status_bloc.dart';
import 'package:movie_app/presentation/widgets/movie_detail/container/cast_list_widget.dart';
import 'package:movie_app/presentation/widgets/movie_detail/container/movie_account_states_widget.dart';
import 'package:movie_app/presentation/widgets/movie_detail/container/movie_detail_widget.dart';
import 'package:movie_app/presentation/widgets/movie_detail/container/review_list_widget.dart';
import 'package:movie_app/presentation/widgets/movie_detail/container/similar_movie_list_widget.dart';
import 'package:movie_app/presentation/widgets/movie_detail/container/video_list_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../injection_container.dart' as di;

class MovieDetailPage extends StatelessWidget {
  final int movieId;

  const MovieDetailPage({Key key, this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("MovieID: $movieId");
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (_) => di.sl<MovieDetailBloc>(),
        ),
        BlocProvider<MovieFavoriteStatusBloc>(
          create: (_) => di.sl<MovieFavoriteStatusBloc>(),
        ),
        BlocProvider<MovieWatchlistStatusBloc>(
          create: (_) => di.sl<MovieWatchlistStatusBloc>(),
        ),
      ],
      child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailInitial) {
            BlocProvider.of<MovieDetailBloc>(context).add(
              GetMovieDetailEvent(movieId),
            );
            return Container();
          }
          return MovieDetailBody();
        },
      ),
    );
  }
}

class MovieDetailBody extends StatelessWidget {
  const MovieDetailBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    final MovieDetailState movieDetailState =
        context.bloc<MovieDetailBloc>().state;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: (movieDetailState is MovieDetailLoaded)
            ? Text(movieDetailState.movieDetail.title)
            : Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Container(
                  height: 20,
                  width: 100,
                  color: Colors.white,
                ),
              ),
        backgroundColor: Colors.white.withOpacity(0.1),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 30),
          color: Colors.white.withOpacity(0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MovieDetailWidget(),
              Divider(
                color: Colors.white.withOpacity(0.8),
              ),
              MovieAccountStatesWidget(),
              Divider(
                color: Colors.white.withOpacity(0.8),
              ),
              ReviewListWidget(),
              Divider(
                color: Colors.white.withOpacity(0.8),
              ),
              VideoListWidget(),
              Divider(
                color: Colors.white.withOpacity(0.8),
              ),
              CastListWidget(),
              Divider(
                color: Colors.white.withOpacity(0.8),
              ),
              SimilarMovieListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
