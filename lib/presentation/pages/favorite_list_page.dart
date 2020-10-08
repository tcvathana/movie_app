import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/account/account_bloc.dart';
import 'package:movie_app/presentation/bloc/account/favorite_movie/favorite_movie_bloc.dart';
import 'package:movie_app/presentation/bloc/authentication/auth_bloc.dart';
import 'package:movie_app/presentation/widgets/account/container/favorite_list_movie_container.dart';
import 'package:page_transition/page_transition.dart';
import 'account_page.dart';

class FavoriteListPage extends StatelessWidget {

  const FavoriteListPage({Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthLoaded authLoaded =context.bloc<AuthBloc>().state;
    final AccountLoadedState accountState = context.bloc<AccountBloc>().state;
    BlocProvider.of<FavoriteMovieBloc>(context).add(
      GetFavoriteMovieEvent(
        sessionId: authLoaded.sessionId,
        accountId: accountState.account.id.toString(),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Favorite List"),
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
      body: Container(
        color: Colors.black87,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10, top: 15),
                child: Text(
                  "Favorite List",
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(0.8),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Sorted by Create At",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.white.withOpacity(0.8),
              ),
              FavoriteListMovieContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
