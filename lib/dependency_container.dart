import 'package:get_it/get_it.dart';
import 'package:movie_app/core/network/networkInfo.dart';
import 'package:movie_app/features/movie/data/data_sources/movie_local_data_source.dart';
import 'package:movie_app/features/movie/data/data_sources/movie_local_data_source_imple.dart';
import 'package:movie_app/features/movie/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/features/movie/data/data_sources/movie_remote_date_source_imple.dart';
import 'package:movie_app/features/movie/domain/repository/movies_repository.dart';
import 'package:movie_app/features/movie/domain/usecases/get_movies_use_case.dart';
import 'package:movie_app/features/movie/presentation/movies_list_vloc/movies_list_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'features/movie/data/repositories/movies-repositories_imple.dart';

GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  // register features
  getIt.registerLazySingletonAsync(() => SharedPreferences.getInstance());

  //bloc
  getIt.registerFactory(() => MoviesListBloc(
        getIt(),
      ));

  // use case
  getIt
      .registerLazySingleton(() => GetMoviesUseCase(moviesRepository: getIt()));

  // repos
  getIt.registerLazySingleton<MoviesRepository>(() => MovieRepositoryImple(
        movieLocalDataSource: getIt(),
        movieRemoteDataSource: getIt(),
        netWorkInfo: getIt(),
      ));

  // register datasources
  getIt.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImple(getIt()));
  getIt.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDateSourceImple(sharedPreferences: getIt()));

  // register core
  getIt.registerLazySingleton<NetWorkInfo>(() => NetworkInfoImple());

  // register extrnal
  getIt.registerLazySingleton(() => http.Client());
}
