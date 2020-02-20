import 'package:flutter/material.dart';
import 'package:vitta_case_mobile/core/styles/styles.dart';
import 'package:vitta_case_mobile/core/widgets/general_widgets.dart';
import 'package:vitta_case_mobile/core/widgets/responsiveness.dart';
import 'package:vitta_case_mobile/features/movies/data/model/movie_detailed_model.dart';
import 'package:vitta_case_mobile/features/movies/presentation/bloc/bloc.dart';
import 'package:vitta_case_mobile/features/movies/presentation/bloc/detailed_movie_bloc/detailed_movie_bloc.dart';

class MovieInfo extends StatelessWidget {
  const MovieInfo({Key key, @required DetailedMovieBloc bloc})
      : _bloc = bloc,
        super(key: key);

  final DetailedMovieBloc _bloc;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: responsiveHeight(context, 100),
      left: responsiveWidth(context, 20),
      right: responsiveWidth(context, 20),
      child: StreamBuilder<MovieDetailedModel>(
        stream: _bloc.movieDetailed.stream,
        builder: (_, AsyncSnapshot<MovieDetailedModel> snapshot) {
          return StreamBuilder<LoadingStatus>(
            stream: _bloc.loadingStatus.stream,
            builder: (_, AsyncSnapshot<LoadingStatus> loadShot) {
              return DefaultAnimatedSwitcher(
                child: loadShot.data == LoadingStatus.LOADING
                    ? CircularProgressIndicator()
                    : loadShot.data == LoadingStatus.ERROR
                        ? Text('Tivemos um problema...')
                        : DefaultAnimatedSwitcher(
                            child: !snapshot.hasData
                                ? Container()
                                : MovieInfoBuilt(snapshot: snapshot)),
              );
            },
          );
        },
      ),
    );
  }
}

class MovieInfoBuilt extends StatelessWidget {
  const MovieInfoBuilt({Key key, @required this.snapshot}) : super(key: key);

  final AsyncSnapshot<MovieDetailedModel> snapshot;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(snapshot.data.title, style: defaultWhiteStyle),
        Text(snapshot.data.genre),
        Text('Diretor: ${snapshot.data.director ?? 'N/A'}'),
        Text('Released Date: ${snapshot.data.releasedDate}'),
        SizedBox(height: responsiveHeight(context, 20)),
        Text(snapshot.data.description,
            textAlign: TextAlign.justify, style: defaultWhiteStyle),
      ],
    );
  }
}
