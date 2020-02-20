import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:vitta_case_mobile/features/movies/data/model/movie_detailed_model.dart';
import 'package:vitta_case_mobile/features/movies/domain/use_cases/get_detailed_movie.dart';
import 'package:vitta_case_mobile/features/movies/presentation/bloc/bloc.dart';
import 'package:vitta_case_mobile/features/movies/presentation/bloc/provider/provider.dart';
import 'package:vitta_case_mobile/features/movies/presentation/bloc/utils/generic_bloc.dart';
import 'package:vitta_case_mobile/injection_container.dart';

class DetailedMovieBloc extends BlocBase {
  final GetDetailedMovie getDetailedMovie;
  final DetailedMovieParamsWidget detailedMovieParamsWidget;

  DetailedMovieBloc(this.detailedMovieParamsWidget)
      : getDetailedMovie = GetDetailedMovie(sl()) {
    getDetailMovie(detailedMovieParamsWidget);
  }

  final GenericBloc<MovieDetailedModel> movieDetailed =
      GenericBloc<MovieDetailedModel>();
  final GenericBloc<LoadingStatus> loadingStatus = GenericBloc<LoadingStatus>();

  Future<void> getDetailMovie(DetailedMovieParamsWidget params) async {
    loadingStatus.sink(LoadingStatus.LOADING);
    final result =
        await getDetailedMovie.repository.getDetailedMovie(params.movieID);
    result.fold((failure) {
      loadingStatus.sink(LoadingStatus.ERROR);
    }, (movie) => movieDetailed.sink(movie));
    loadingStatus.sink(LoadingStatus.IDLE);
  }

  @override
  void dispose() {
    movieDetailed?.dispose();
    loadingStatus?.dispose();
  }
}

class DetailedMovieParamsWidget {
  DetailedMovieParamsWidget(
      {@required this.movieID, this.pallete, this.baseImage});

  final String movieID;
  final String baseImage;
  final PaletteGenerator pallete;
}
