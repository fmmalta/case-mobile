import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:vitta_case_mobile/core/services/navigation_service.dart';
import 'package:vitta_case_mobile/core/services/validations.dart';
import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object.dart';
import 'package:vitta_case_mobile/features/movies/domain/use_cases/get_searched_movies.dart';
import 'package:vitta_case_mobile/features/movies/presentation/bloc/provider/provider.dart';
import 'package:vitta_case_mobile/features/movies/presentation/bloc/utils/generic_bloc.dart';
import 'package:vitta_case_mobile/injection_container.dart';

import '../bloc.dart';

class HomeBloc extends BlocBase {
  HomeBloc() : getSearchedMovies = GetSearchedMovies(sl()) {
    //listenToMovieQueries();
  }

  final GetSearchedMovies getSearchedMovies;

  final GenericBloc<String> query = GenericBloc<String>();
  final GenericBloc<String> errorMessage = GenericBloc<String>();
  final GenericBloc<List<Movie>> searchedMovies = GenericBloc<List<Movie>>();
  final GenericBloc<LoadingStatus> loadingStatus = GenericBloc<LoadingStatus>();
  final TextEditingController controller = TextEditingController();

  Future<void> listenToMovieQueries(BuildContext context, String value) async {
    if (value.isNotEmpty) {
      if (StrUtils.validateName(value) == null) {
        try {
          loadingStatus.sink(LoadingStatus.LOADING);
          final result =
              await getSearchedMovies.repository.searchedMovie(value);
          result?.fold((failure) {
            loadingStatus.sink(LoadingStatus.ERROR);
            return searchedMovies.sink(null);
          }, (movie) {
            loadingStatus.sink(LoadingStatus.SUCCESS);
            return searchedMovies.sink(movie);
          });

          clearTextField(context);
        } catch (e) {
          print(e);
          loadingStatus.sink(LoadingStatus.ERROR);
          print('Ocorreu um erro inesperado');
        }
      } else {
        loadingStatus.sink(LoadingStatus.ERROR);
        errorMessage.sink(StrUtils.validateName(value));
      }
    }
  }

  Future generatePalette(String imagePath, String movieID) async {
    PaletteGenerator _palette = await PaletteGenerator.fromImageProvider(
        NetworkImage(imagePath),
        maximumColorCount: 20);

    navigationService.pushNamed('/detail_page',
        args: DetailedMovieParamsWidget(
          baseImage: imagePath,
          pallete: _palette,
          movieID: movieID,
        ));
  }

  void clearTextField(BuildContext context) {
    controller?.clear();
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void dispose() {
    query?.dispose();
    searchedMovies?.dispose();
    controller?.dispose();
    loadingStatus?.dispose();
  }
}

enum LoadingStatus { IDLE, LOADING, SUCCESS, ERROR }
