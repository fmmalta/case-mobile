import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:vitta_case_mobile/core/error/exceptions.dart';
import 'package:vitta_case_mobile/core/error/failure.dart';
import 'package:vitta_case_mobile/features/movies/data/data_source/movies_remote_data_source.dart';
import 'package:vitta_case_mobile/features/movies/data/model/movie_detailed_model.dart';
import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object.dart';
import 'package:vitta_case_mobile/features/movies/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  MoviesRepositoryImpl({@required this.moviesRemoteDataSource});

  final MoviesRemoteDataSource moviesRemoteDataSource;

  @override
  Future<Either<Failure, MovieDetailedModel>> getDetailedMovie(
      String movieID) async {
    final detailedMovie =
        await moviesRemoteDataSource.getDetailedMovie(movieID);
    return Right(detailedMovie);
  }

  @override
  Future<Either<Failure, List<Movie>>> searchedMovie(String query) async {
    try {
      final searchedMovies = await moviesRemoteDataSource.searchedMovie(query);
      return Right(searchedMovies);
    } on ServerException {
      print('Movie not found');
      return null;
    }
  }
}
