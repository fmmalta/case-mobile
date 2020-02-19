import 'package:vitta_case_mobile/core/error/exceptions.dart';
import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object.dart';
import 'package:vitta_case_mobile/features/movies/domain/use_cases/get_searched_movies.dart';
import 'package:vitta_case_mobile/features/movies/presentation/bloc/provider/provider.dart';
import 'package:vitta_case_mobile/features/movies/presentation/bloc/utils/generic_bloc.dart';
import 'package:vitta_case_mobile/injection_container.dart';

class HomeBloc extends BlocBase {
  HomeBloc() : getSearchedMovies = GetSearchedMovies(sl()) {
    listenToMovieQueries();
  }

  final GetSearchedMovies getSearchedMovies;

  final GenericBloc<String> query = GenericBloc<String>();
  final GenericBloc<List<Movie>> searchedMovies = GenericBloc<List<Movie>>();

  void listenToMovieQueries() {
    query.streamDebounce.listen((String value) async {
      if (value.isNotEmpty) {
        try {
          final result =
              await getSearchedMovies.repository.searchedMovie(value);
          result.fold(
              (failure) => print('Opa'), (movie) => searchedMovies.sink(movie));
        } on ServerException {
          print('Ocorreu um erro inesperado');
        }
      }
    });
  }

  @override
  void dispose() {
    query?.dispose();
    searchedMovies?.dispose();
  }
}
