import 'package:flutter/material.dart';
import 'package:vitta_case_mobile/features/movies/presentation/bloc/bloc.dart';
import 'package:vitta_case_mobile/features/movies/presentation/widgets/detailed_movie_widgets/movie_info.dart';
import 'package:vitta_case_mobile/features/movies/presentation/widgets/detailed_movie_widgets/movie_poster.dart';

class DetailedMoviePage extends StatefulWidget {
  const DetailedMoviePage({Key key, this.detailedMovieParams})
      : super(key: key);
  final DetailedMovieParamsWidget detailedMovieParams;

  @override
  _DetailedMoviePageState createState() => _DetailedMoviePageState();
}

class _DetailedMoviePageState extends State<DetailedMoviePage> {
  DetailedMovieBloc _bloc;

  @override
  void initState() {
    _bloc = DetailedMovieBloc(widget.detailedMovieParams);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        blocBuilder: () => _bloc,
        blocDispose: (_) => _bloc?.dispose(),
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              MovieCoverPoster(widget: widget),
              Container(
                color: widget.detailedMovieParams.pallete.dominantColor.color
                    .withOpacity(0.7),
              ),
              MovieInfo(bloc: _bloc),
              BackButton(),
            ],
          ),
        ));
  }
}
