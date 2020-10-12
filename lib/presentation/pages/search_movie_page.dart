import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:movie_app/presentation/widgets/search_movie/container/search_movie_list_widget.dart';
import '../../injection_container.dart' as di;

class SearchMoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<SearchMovieBloc>(),
      child: BlocBuilder<SearchMovieBloc, SearchMovieState>(
        builder: (BuildContext context, SearchMovieState state){
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.white.withOpacity(0.1),
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
                  onSubmitted: (query) => dispatchSearchMovie(context, query),
                ),
              ),
            ),
            body: Container(
              color: Colors.white.withOpacity(0.2),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: SearchMovieListWidget(),
            ),
          );
        },
      ),
    );
  }

  void dispatchSearchMovie(BuildContext context, String query) {
    BlocProvider.of<SearchMovieBloc>(context).add(GetSearchEvent(query));
  }
}
