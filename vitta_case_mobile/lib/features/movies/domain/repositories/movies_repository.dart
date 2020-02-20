import 'package:dartz/dartz.dart';
import 'package:vitta_case_mobile/core/error/failure.dart';
import 'package:vitta_case_mobile/features/movies/data/model/movie_detailed_model.dart';
import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<Movie>>> searchedMovie(String query);

  Future<Either<Failure, MovieDetailedModel>> getDetailedMovie(String movieID);
}
