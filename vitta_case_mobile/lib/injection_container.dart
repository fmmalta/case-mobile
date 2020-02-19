import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:vitta_case_mobile/features/movies/data/data_source/movies_remote_data_source.dart';
import 'package:vitta_case_mobile/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:vitta_case_mobile/features/movies/domain/use_cases/get_detailed_movie.dart';
import 'package:vitta_case_mobile/features/movies/domain/use_cases/get_searched_movies.dart';
import 'package:vitta_case_mobile/features/movies/presentation/bloc/detailed_movie_bloc/detailed_movie_bloc.dart';
import 'package:vitta_case_mobile/features/movies/presentation/bloc/home_bloc/home_bloc.dart';

import 'features/movies/domain/repositories/movies_repository.dart';

final GetIt sl = GetIt.instance;

Future<void> initInjection() async {
  /// Blocs
  sl.registerFactory(() => HomeBloc());
  sl.registerFactory(() => DetailedMovieBloc(sl()));

  /// Use cases
  sl.registerLazySingleton(() => GetSearchedMovies(sl()));
  sl.registerLazySingleton(() => GetDetailedMovie(sl()));

  /// Repository
  sl.registerLazySingleton<MoviesRepository>(
      () => MoviesRepositoryImpl(moviesRemoteDataSource: sl()));

  /// Data sources
  sl.registerLazySingleton<MoviesRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: sl()));

  /// External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
