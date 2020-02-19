import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:vitta_case_mobile/core/services/navigation_service.dart';
import 'package:vitta_case_mobile/core/styles/styles.dart';
import 'package:vitta_case_mobile/core/widgets/responsiveness.dart';
import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object.dart';
import 'package:vitta_case_mobile/features/movies/presentation/bloc/detailed_movie_bloc/detailed_movie_bloc.dart';
import 'package:vitta_case_mobile/features/movies/presentation/bloc/home_bloc/home_bloc.dart';

class SearchedMoviesResult extends StatelessWidget {
  const SearchedMoviesResult({Key key, @required HomeBloc bloc})
      : _bloc = bloc,
        super(key: key);

  final HomeBloc _bloc;

  @override
  Widget build(BuildContext context) {
    final double _width = deviceSize(context).width;
    final double _height = deviceSize(context).height;
    final double _aspectRatio = _width / _height;
    return StreamBuilder<List<Movie>>(
      initialData: [],
      stream: _bloc.searchedMovies.stream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        return Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: _aspectRatio),
            itemCount: snapshot.data.length,
            padding: EdgeInsets.all(responsiveWidth(context, 10)),
            shrinkWrap: true,
            itemBuilder: (_, int index) {
              final Movie _movie = snapshot.data[index];
              return InkWell(
                onTap: () => generatePalette(
                  _movie.moviePoster,
                  _movie.movieID,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 20,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: MoviePoster(movie: _movie),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
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
}

class MovieTitle extends StatelessWidget {
  const MovieTitle({Key key, @required Movie movie})
      : _movie = movie,
        super(key: key);

  final Movie _movie;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text(
        _movie.title,
        textAlign: TextAlign.center,
        style: defaultBlackStyle,
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  const MoviePoster({Key key, @required Movie movie})
      : _movie = movie,
        super(key: key);

  final Movie _movie;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Image.network(_movie.moviePoster, fit: BoxFit.cover),
      borderRadius: BorderRadius.circular(5),
    );
  }
}
