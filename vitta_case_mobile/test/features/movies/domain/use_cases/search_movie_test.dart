import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object.dart';
import 'package:vitta_case_mobile/features/movies/domain/repositories/movies_repository.dart';
import 'package:vitta_case_mobile/features/movies/domain/use_cases/get_all_movies.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {}

void main() {
  GetAllMovies useCase;
  MockMoviesRepository mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = MockMoviesRepository();
    useCase = GetAllMovies(mockMoviesRepository);
  });

  final String tQuery = 'Batman Begins';
  final Movie tMovie = Movie(
      title: 'Batman Begins',
      movieID: 'tt0372784',
      moviePoster:
          'https://m.media-amazon.com/images/M/MV5BZmUwNGU2ZmItMmRiNC00MjhlLTg5YWUtODMyNzkxODYzMmZlXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SX300.jpg',
      year: '2005');
  test('should get all movies when requested', () async {
    when(mockMoviesRepository.searchedMovie(any))
        .thenAnswer((_) async => Right(tMovie));

    final result = await useCase(SearchMovieParams(query: tQuery));

    expect(result, Right(tMovie));
    expect(tQuery, tMovie.title);
    verify(mockMoviesRepository.searchedMovie(tQuery));
    verifyNoMoreInteractions(mockMoviesRepository);
  });
}
