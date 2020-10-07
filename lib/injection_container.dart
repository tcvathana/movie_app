import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/data/data_sources/local/movie_detail_local_data_source.dart';
import 'package:movie_app/data/data_sources/local/movie_local_data_source.dart';
import 'package:movie_app/data/data_sources/local/search_local_data_source.dart';
import 'package:movie_app/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:movie_app/data/data_sources/remote/movie_detail_remote_data_source.dart';
import 'package:movie_app/data/data_sources/remote/movie_remote_data_source.dart';
import 'package:movie_app/data/data_sources/remote/search_remote_data_source.dart';
import 'package:movie_app/data/repositories/auth_repository.dart';
import 'package:movie_app/data/repositories/movie_detail_repository.dart';
import 'package:movie_app/data/repositories/movie_repository.dart';
import 'package:movie_app/data/repositories/search_repository.dart';
import 'package:movie_app/presentation/bloc/authentication/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(() => AuthBloc(authRepository: sl()));
  // Use Case
  // Repository
  sl.registerLazySingleton(() => AuthRepository(remoteDataSource: sl()));
  sl.registerLazySingleton(() => MovieRepository(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton(() => MovieDetailRepository(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton(() => SearchRepository(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
  // Data source
  sl.registerLazySingleton(() => AuthRemoteDataSource());
  sl.registerLazySingleton(() => MovieRemoteDataSource());
  sl.registerLazySingleton(() => MovieLocalDataSource(sharedPreferences: sl()));
  sl.registerLazySingleton(() => MovieDetailRemoteDataSource());
  sl.registerLazySingleton(
      () => MovieDetailLocalDataSource(sharedPreferences: sl()));
  sl.registerLazySingleton(() => SearchRemoteDataSource());
  sl.registerLazySingleton(
      () => SearchLocalDataSource(sharedPreferences: sl()));
  // Core
  sl.registerLazySingleton(() => NetworkInfo(connectionChecker: sl()));
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
//  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
