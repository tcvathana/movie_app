import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/data/data_sources/local/movie_local_data_source.dart';
import 'package:movie_app/data/data_sources/remote/movie_remote_data_source.dart';
import 'package:movie_app/data/repositories/movie_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  // Use Case
  // Repository
  sl.registerLazySingleton(() => MovieRepository(
    remoteDataSource: sl(),
    localDataSource: sl(),
    networkInfo: sl(),
  ));
  // Data source
  sl.registerLazySingleton(() => MovieRemoteDataSource());
  sl.registerLazySingleton(() => MovieLocalDataSource(sharedPreferences: sl()));
  // Core
  sl.registerLazySingleton(() => NetworkInfo(connectionChecker: sl()));
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
//  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}