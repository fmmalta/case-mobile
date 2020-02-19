import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vitta_case_mobile/core/error/exceptions.dart';
import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object.dart';
import 'package:vitta_case_mobile/features/movies/domain/repositories/movies_repository.dart';
import 'package:vitta_case_mobile/features/movies/domain/use_cases/get_searched_movies.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {}

void main() {
  GetSearchedMovies useCase;
  MockMoviesRepository mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = MockMoviesRepository();
    useCase = GetSearchedMovies(mockMoviesRepository);
  });

  final String tQuery = 'Batman Begins';
  final tMovie = <Movie>[
    Movie(
        title: 'Batman Begins',
        movieID: 'tt0372784',
        moviePoster:
            'https://m.media-amazon.com/images/M/MV5BZmUwNGU2ZmItMmRiNC00MjhlLTg5YWUtODMyNzkxODYzMmZlXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SX300.jpg',
        year: '2005')
  ];
  group('Searched Movies', () {
    test('should get all movies when requested with [$tQuery]', () async {
      when(mockMoviesRepository.searchedMovie(any))
          .thenAnswer((_) async => Right(tMovie));

      final result = await useCase(SearchMovieParams(query: tQuery));

      expect(result, Right(tMovie));

      verify(mockMoviesRepository.searchedMovie(tQuery));
      verifyNoMoreInteractions(mockMoviesRepository);
    });

    test('should get no movies when requested with empty query', () async {
      when(mockMoviesRepository.searchedMovie(''))
          .thenAnswer((_) async => Left(ServerFailure()));

      final result = await useCase(SearchMovieParams(query: ''));

      expect(result, Left(ServerFailure()));

      verify(mockMoviesRepository.searchedMovie(''));
      verifyNoMoreInteractions(mockMoviesRepository);
    });
  });
}
