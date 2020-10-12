import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/account/account_bloc.dart';
import 'package:movie_app/presentation/bloc/authentication/auth_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_watchlist_status/movie_watchlist_status_bloc.dart';

class ButtonAddToWatchList extends StatelessWidget {
  const ButtonAddToWatchList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthLoaded authLoaded = context.bloc<AuthBloc>().state;
    final MovieDetailLoaded movieDetailLoaded =
        context.bloc<MovieDetailBloc>().state;
    BlocProvider.of<MovieWatchlistStatusBloc>(context).add(
      GetMovieWatchlistStatusEvent(
        sessionId: authLoaded.sessionId,
        mediaId: movieDetailLoaded.movieDetail.id,
      ),
    );
    return BlocBuilder<MovieWatchlistStatusBloc, MovieWatchlistStatusState>(
      builder: (context, state) {
        if (state is MovieWatchlistStatusInitial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is MovieWatchlistStatusLoaded) {
          return WatchlistButtonWidget();
        }
        if (state is MovieWatchlistStatusError) {
          return Center(child: Text(state.error));
        }
        if (state is MovieWatchlistStatusLoading) {
          return Container(
            width: MediaQuery.of(context).size.width / 2 - 20,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Center(
          child: Text("Unknown"),
        );
      },
    );
  }
}

class WatchlistButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MovieWatchlistStatusLoaded loadedWatchlist =
        context.bloc<MovieWatchlistStatusBloc>().state;
    if (loadedWatchlist.isWatchlist) {
      return buildWatchlistButton(context);
    }
    return buildNonWatchlistButton(context);
  }

  Widget buildNonWatchlistButton(context) {
    return InkWell(
      onTap: () {
        dispatchAddToWatchlist(context, true);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 0.5,
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "WatchList",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWatchlistButton(context) {
    return InkWell(
      onTap: () {
        dispatchAddToWatchlist(context, false);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.0),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 0.5,
          ),
        ),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.done,
              color: Colors.white,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              "Watchlist",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void dispatchAddToWatchlist(context, bool isWatchlist) {
    final AuthLoaded authLoaded = BlocProvider.of<AuthBloc>(context).state;
    final AccountLoadedState accLoaded =
        BlocProvider.of<AccountBloc>(context).state;
    final MovieDetailLoaded movieDetailLoaded =
        BlocProvider.of<MovieDetailBloc>(context).state;
    BlocProvider.of<MovieWatchlistStatusBloc>(context).add(
      AddToWatchlistEvent(
        sessionId: authLoaded.sessionId,
        accountId: accLoaded.account.id,
        mediaId: movieDetailLoaded.movieDetail.id,
        watchlist: isWatchlist,
      ),
    );
  }
}
