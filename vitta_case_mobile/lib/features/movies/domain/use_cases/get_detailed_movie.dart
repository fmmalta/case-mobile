import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vitta_case_mobile/core/error/failure.dart';
import 'package:vitta_case_mobile/core/use_cases/use_cases.dart';
import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object_detailed.dart';
import 'package:vitta_case_mobile/features/movies/domain/repositories/movies_repository.dart';

class GetDetailedMovie
    implements DetailedMovieUseCase<MovieDetailed, MovieDetailedParams> {
  GetDetailedMovie(this.repository);

  final MoviesRepository repository;

  @override
  Future<Either<Failure, MovieDetailed>> call(
      MovieDetailedParams params) async {
    return await repository.getDetailedMovie(params.movieID);
  }
}

class MovieDetailedParams extends Equatable {
  MovieDetailedParams({@required this.movieID});

  final String movieID;

  @override
  List<Object> get props => [movieID];
}
