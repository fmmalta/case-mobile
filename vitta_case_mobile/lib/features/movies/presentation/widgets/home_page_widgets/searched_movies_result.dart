import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:vitta_case_mobile/core/styles/styles.dart';
import 'package:vitta_case_mobile/core/widgets/general_widgets.dart';
import 'package:vitta_case_mobile/core/widgets/responsiveness.dart';
import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object.dart';
import 'package:vitta_case_mobile/features/movies/presentation/bloc/home_bloc/home_bloc.dart';

class SearchedMoviesResult extends StatelessWidget {
  const SearchedMoviesResult({Key key, @required HomeBloc bloc})
      : _bloc = bloc,
        super(key: key);

  final HomeBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Movie>>(
      stream: _bloc.searchedMovies.stream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        return Expanded(
          child: StreamBuilder<LoadingStatus>(
            stream: _bloc.loadingStatus.stream,
            builder: (_, AsyncSnapshot<LoadingStatus> loadShot) {
              print('Loashot: ${loadShot.data}');
              return DefaultAnimatedSwitcher(
                child: loadShot.data == LoadingStatus.LOADING
                    ? CircularProgressIndicator()
                    : loadShot.data == LoadingStatus.ERROR
                        ? NoMovieFound()
                        : DefaultAnimatedSwitcher(
                            child: !snapshot.hasData
                                ? Center(
                                    child: Text('Pesquise por um filme...'))
                                : MoviesSearchedBuilt(
                                    snapshot: snapshot, bloc: _bloc),
                          ),
              );
            },
          ),
        );
      },
    );
  }
}

class NoMovieFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: deviceSize(context).height / 3,
          child: FlareActor(
            'flare/error-message.flr',
            animation: 'error-message',
          ),
        ),
        SizedBox(height: responsiveHeight(context, 20)),
        Text('Nenhum filme encontrado...')
      ],
    );
  }
}

class MoviesSearchedBuilt extends StatelessWidget {
  const MoviesSearchedBuilt(
      {Key key, @required this.snapshot, @required this.bloc})
      : super(key: key);

  final AsyncSnapshot<List<Movie>> snapshot;
  final HomeBloc bloc;

  @override
  Widget build(BuildContext context) {
    final double _width = deviceSize(context).width;
    final double _height = deviceSize(context).height;
    final double _aspectRatio = _width / _height;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: _aspectRatio),
      itemCount: snapshot.data.length,
      padding: EdgeInsets.all(responsiveWidth(context, 10)),
      shrinkWrap: true,
      itemBuilder: (_, int index) {
        final Movie _movie = snapshot.data[index];
        return InkWell(
          onTap: _movie.moviePoster != 'N/A'
              ? () => bloc.generatePalette(_movie.moviePoster, _movie.movieID)
              : null,
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
    );
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
      child: _movie.moviePoster == 'N/A'
          ? Image.asset('images/not-found.png', fit: BoxFit.cover)
          : Image.network(_movie.moviePoster, fit: BoxFit.cover),
      borderRadius: BorderRadius.circular(5),
    );
  }
}
