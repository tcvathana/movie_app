import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/data/data_sources/local/account_local_data_source.dart';
import 'package:movie_app/data/data_sources/local/movie_detail_local_data_source.dart';
import 'package:movie_app/data/data_sources/local/movie_local_data_source.dart';
import 'package:movie_app/data/data_sources/local/search_local_data_source.dart';
import 'package:movie_app/data/data_sources/remote/account_remote_data_source.dart';
import 'package:movie_app/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:movie_app/data/data_sources/remote/movie_detail_remote_data_source.dart';
import 'package:movie_app/data/data_sources/remote/movie_remote_data_source.dart';
import 'package:movie_app/data/data_sources/remote/search_remote_data_source.dart';
import 'package:movie_app/data/repositories/account_repository.dart';
import 'package:movie_app/data/repositories/auth_repository.dart';
import 'package:movie_app/data/repositories/movie_detail_repository.dart';
import 'package:movie_app/data/repositories/movie_repository.dart';
import 'package:movie_app/data/repositories/search_repository.dart';
import 'package:movie_app/presentation/bloc/account/account_bloc.dart';
import 'package:movie_app/presentation/bloc/account/favorite_movie/favorite_movie_bloc.dart';
import 'package:movie_app/presentation/bloc/account/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movie_app/presentation/bloc/authentication/auth_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_favorite_status/movie_favorite_status_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_detail/movie_watchlist_status/movie_watchlist_status_bloc.dart';
import 'package:movie_app/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:movie_app/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(
    () => AuthBloc(
      authRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => AccountBloc(
      accountRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => FavoriteMovieBloc(
      accountRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => WatchlistMovieBloc(
      accountRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => MovieDetailBloc(
      movieDetailRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => MovieFavoriteStatusBloc(
      accountRepository: sl(),
      movieDetailRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => MovieWatchlistStatusBloc(
      accountRepository: sl(),
      movieDetailRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => MovieListBloc(
      movieRepository: sl(),
    ),
  );
  sl.registerFactory(
    () => SearchMovieBloc(
      searchRepository: sl(),
    ),
  );
  // Use Case
  // Repository
  sl.registerLazySingleton(
    () => AuthRepository(
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => AccountRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => MovieRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => MovieDetailRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SearchRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data source
  sl.registerLazySingleton(
    () => AuthRemoteDataSource(),
  );
  sl.registerLazySingleton(
    () => AccountRemoteDataSource(),
  );
  sl.registerLazySingleton(
    () => AccountLocalDataSource(
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => MovieRemoteDataSource(),
  );
  sl.registerLazySingleton(
    () => MovieLocalDataSource(
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => MovieDetailRemoteDataSource(),
  );
  sl.registerLazySingleton(
    () => MovieDetailLocalDataSource(
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SearchRemoteDataSource(),
  );
  sl.registerLazySingleton(
    () => SearchLocalDataSource(
      sharedPreferences: sl(),
    ),
  );
  // Core
  sl.registerLazySingleton(
    () => NetworkInfo(
      connectionChecker: sl(),
    ),
  );
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
//  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
