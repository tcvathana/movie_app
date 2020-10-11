import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/authentication/auth_bloc.dart';
import '../button_add_to_watchlist.dart';
import '../button_mark_as_favorite.dart';

class MovieAccountStatesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) {
      if (state is AuthLoaded) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonMarkAsFavorite(),
              ButtonAddToWatchList(),
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
