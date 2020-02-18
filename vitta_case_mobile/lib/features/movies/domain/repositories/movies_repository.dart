import 'package:dartz/dartz.dart';
import 'package:vitta_case_mobile/core/error/failure.dart';
import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object.dart';
import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object_detailed.dart';

abstract class MoviesRepository {
  Future<Either<Failure, Movie>> searchedMovie(String query);

  Future<Either<Failure, MovieDetailed>> getDetailedMovie(String movieID);
}
