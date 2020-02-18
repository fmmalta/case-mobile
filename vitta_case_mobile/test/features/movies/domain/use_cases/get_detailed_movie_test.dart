import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object_detailed.dart';
import 'package:vitta_case_mobile/features/movies/domain/repositories/movies_repository.dart';
import 'package:vitta_case_mobile/features/movies/domain/use_cases/get_detailed_movie.dart';

class MockMoviesRepository extends Mock implements MoviesRepository {}

void main() {
  GetDetailedMovie useCase;
  MockMoviesRepository mockMoviesRepository;

  setUp(() {
    mockMoviesRepository = MockMoviesRepository();
    useCase = GetDetailedMovie(mockMoviesRepository);
  });

  final tMovieID = 'tt0372784';
  final tDetailedMovie = MovieDetailed(
      title: 'Batman Begins',
      description:
          'After training with his mentor, Batman begins his fight to free crime-ridden Gotham City from corruption.',
      moviePoster:
          'https://m.media-amazon.com/images/M/MV5BZmUwNGU2ZmItMmRiNC00MjhlLTg5YWUtODMyNzkxODYzMmZlXkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SX300.jpg',
      releasedDate: '15 Jun 2005',
      genre: 'Action, Adventure, Fantasy, Thriller');
  test('should return a movie when requested with a movie id', () async {
    when(mockMoviesRepository.getDetailedMovie(any))
        .thenAnswer((_) async => Right(tDetailedMovie));

    final result = await useCase(MovieDetailedParams(movieID: tMovieID));

    expect(result, Right(tDetailedMovie));
  });
}
