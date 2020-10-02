import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../../../config.dart';
import '../../models/movie_list.dart';

abstract class ISearchRemoteDataSource {
  Future<MovieList> fetchSearchMovie({@required String query});
}

class SearchRemoteDataSource implements ISearchRemoteDataSource {
  @override
  Future<MovieList> fetchSearchMovie({@required String query}) async {
    http.Response response =
        await http.get("$BASE_URL/search/movie?api_key=$API_KEY&query=$query");
    if (response.statusCode == 200) {
      return MovieList.fromJson(response.body);
    } else {
      throw Exception("Error ${response.toString()}");
    }
  }
}
