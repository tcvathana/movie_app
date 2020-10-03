import 'package:meta/meta.dart';
import 'package:movie_app/data/models/movie_account_states.dart';
import '../../core/network/network_info.dart';
import '../../domain/repositories/i_movie_detail_repository.dart';
import '../models/movie_credits.dart';
import '../models/movie_detail.dart';
import '../models/movie_list.dart';
import '../models/movie_review.dart';
import '../models/movie_video.dart';
import '../data_sources/remote/movie_detail_remote_data_source.dart';
import '../data_sources/local/movie_detail_local_data_source.dart';

class MovieDetailRepository implements IMovieDetailRepository {
  final MovieDetailRemoteDataSource remoteDataSource;
  final MovieDetailLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieDetailRepository({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<MovieCredit> getMovieCredit({@required String movieId}) async {
    if (await networkInfo.isConnected) {
      final remoteMovieCredit = await remoteDataSource.fetchMovieCredit(
        movieId: movieId,
      );
      localDataSource.cacheMovieCredit(
        movieId: movieId,
        movieCredit: remoteMovieCredit,
      );
      return remoteMovieCredit;
    } else {
      return localDataSource.getMovieCredit(movieId: movieId);
    }
  }

  @override
  Future<MovieDetail> getMovieDetail({@required String movieId}) async {
    if (await networkInfo.isConnected) {
      final remoteMovieDetail = await remoteDataSource.fetchMovieDetail(
        movieId: movieId,
      );
      localDataSource.cacheMovieDetail(
        movieId: movieId,
        movieDetail: remoteMovieDetail,
      );
      return remoteMovieDetail;
    } else {
      return localDataSource.getMovieDetail(movieId: movieId);
    }
  }

  @override
  Future<MovieReview> getMovieReview({@required String movieId}) async {
    if (await networkInfo.isConnected) {
      final remoteMovieReview = await remoteDataSource.fetchMovieReview(
        movieId: movieId,
      );
      localDataSource.cacheMovieReview(
        movieId: movieId,
        movieReview: remoteMovieReview,
      );
      return remoteMovieReview;
    } else {
      return localDataSource.getMovieReview(movieId: movieId);
    }
  }

  @override
  Future<MovieList> getMovieSimilar({@required String movieId}) async {
    if (await networkInfo.isConnected) {
      final remoteMovieSimilar = await remoteDataSource.fetchMovieSimilar(
        movieId: movieId,
      );
      localDataSource.cacheMovieSimilar(
        movieId: movieId,
        movieList: remoteMovieSimilar,
      );
      return remoteMovieSimilar;
    } else {
      return localDataSource.getMovieSimilar(movieId: movieId);
    }
  }

  @override
  Future<MovieVideo> getMovieVideo({@required String movieId}) async {
    if (await networkInfo.isConnected) {
      final remoteMovieVideo = await remoteDataSource.fetchMovieVideo(
        movieId: movieId,
      );
      localDataSource.cacheMovieVideo(
        movieId: movieId,
        movieVideo: remoteMovieVideo,
      );
      return remoteMovieVideo;
    } else {
      return localDataSource.getMovieVideo(movieId: movieId);
    }
  }

  @override
  Future<MovieAccountStates> getMovieAccountStates({
    @required String sessionId,
    @required int movieId,
  }) async {
    return remoteDataSource.fetchMovieAccountStates(
      sessionId: sessionId,
      movieId: movieId,
    );
  }
}
