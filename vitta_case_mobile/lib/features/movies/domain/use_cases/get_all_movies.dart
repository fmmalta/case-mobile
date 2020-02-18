import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vitta_case_mobile/core/error/failure.dart';
import 'package:vitta_case_mobile/core/use_cases/use_cases.dart';
import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object.dart';
import 'package:vitta_case_mobile/features/movies/domain/repositories/movies_repository.dart';

class GetAllMovies implements SearchedMovieUseCase<Movie, SearchMovieParams> {
  GetAllMovies(this.repository);

  final MoviesRepository repository;

  @override
  Future<Either<Failure, Movie>> call(SearchMovieParams params) async {
    return await repository.searchedMovie(params.query);
  }
}

class SearchMovieParams extends Equatable {
  SearchMovieParams({@required this.query});

  final String query;

  @override
  // TODO: implement props
  List<Object> get props => [query];
}
