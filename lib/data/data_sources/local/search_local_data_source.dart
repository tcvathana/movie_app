import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/movie_list.dart';

abstract class ISearchLocalDataSource {
  Future<MovieList> getSearchMovie({@required String query});
  Future<void> cacheSearchMovie({@required String query});
}

class SearchLocalDataSource implements ISearchLocalDataSource {
  final SharedPreferences sharedPreferences;

  SearchLocalDataSource({@required this.sharedPreferences});

  @override
  Future<MovieList> getSearchMovie({@required String query}) {
    final String jsonString = sharedPreferences.getString("search/movie/$query");
    if (jsonString != null) {
      return Future.value(MovieList.fromJson(jsonString));
    } else {
      throw Exception("Cache error");
    }
  }

  @override
  Future<void> cacheSearchMovie({
    @required String query,
    @required MovieList movieList,
  }) {
    return sharedPreferences.setString(
      "search/movie/$query",
      movieList.toJson(),
    );
  }
}