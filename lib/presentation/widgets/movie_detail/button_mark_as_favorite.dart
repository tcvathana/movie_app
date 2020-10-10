import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/account/account_bloc.dart';
import 'package:movie_app/presentation/bloc/authentication/auth_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_favorite_status/movie_favorite_status_bloc.dart';

class ButtonMarkAsFavorite extends StatelessWidget {
  const ButtonMarkAsFavorite({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthLoaded authLoaded = context.bloc<AuthBloc>().state;
    final MovieDetailLoaded movieDetailLoaded =
        context.bloc<MovieDetailBloc>().state;
    BlocProvider.of<MovieFavoriteStatusBloc>(context).add(
      GetMovieFavoriteStatusEvent(
        sessionId: authLoaded.sessionId,
        mediaId: movieDetailLoaded.movieDetail.id,
      ),
    );
    return BlocBuilder<MovieFavoriteStatusBloc, MovieFavoriteStatusState>(
      builder: (context, state) {
        if (state is MovieFavoriteStatusInitial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is MovieFavoriteStatusLoaded) {
          return FavoriteButtonWidget();
        }
        if (state is MovieFavoriteStatusError) {
          return Center(child: Text(state.error));
        }
        if (state is MovieFavoriteStatusLoading) {
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

class FavoriteButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MovieFavoriteStatusLoaded loadedFavoriteStatus =
        context.bloc<MovieFavoriteStatusBloc>().state;
    if (loadedFavoriteStatus.isFavorite) {
      return buildFavoriteButton(context);
    }
    return buildNonFavoriteButton(context);
  }

  Widget buildNonFavoriteButton(context) {
    return InkWell(
      onTap: () {
        dispatchMarkAsFavorite(context, true);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 0.5,
            )),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.favorite_border,
              color: Colors.red,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              "Mark As Favorite",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFavoriteButton(context) {
    return InkWell(
      onTap: () {
        dispatchMarkAsFavorite(context, false);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.0),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 0.5,
            )),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              "Added to Favorite",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void dispatchMarkAsFavorite(context, bool isFavorite) {
    final AuthLoaded authLoaded = BlocProvider.of<AuthBloc>(context).state;
    final AccountLoadedState accLoaded =
        BlocProvider.of<AccountBloc>(context).state;
    final MovieDetailLoaded movieDetailLoaded =
        BlocProvider.of<MovieDetailBloc>(context).state;
    BlocProvider.of<MovieFavoriteStatusBloc>(context).add(
      MarkAsFavoriteEvent(
        sessionId: authLoaded.sessionId,
        accountId: accLoaded.account.id,
        mediaId: movieDetailLoaded.movieDetail.id,
        favorite: isFavorite,
      ),
    );
  }
}
