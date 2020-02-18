import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vitta_case_mobile/core/error/failure.dart';

abstract class SearchedMovieUseCase<Type, SearchMovieParams> {
  Future<Either<Failure, Type>> call(SearchMovieParams params);
}

abstract class DetailedMovieUseCase<Type, DetailedMovieParams> {
  Future<Either<Failure, Type>> call(DetailedMovieParams params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => <dynamic>[];
}
