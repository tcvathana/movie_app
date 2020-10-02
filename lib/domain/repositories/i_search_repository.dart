import 'package:meta/meta.dart';
import '../../data/models/movie_list.dart';

abstract class ISearchRepository {
  Future<MovieList> getSearchMovie({@required String query});
}