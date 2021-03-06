import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/account/favorite_movie/favorite_movie_bloc.dart';
import 'package:movie_app/presentation/bloc/authentication/auth_bloc.dart';
import 'presentation/bloc/account/account_bloc.dart';
import 'presentation/bloc/account/watchlist_movie/watchlist_movie_bloc.dart';
import 'presentation/bloc/movie_list/movie_list_bloc.dart';
import 'presentation/pages/home_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<AccountBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<FavoriteMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.sl<MovieListBloc>(),
        ),
      ],
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
