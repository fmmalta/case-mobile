import 'package:flutter/material.dart';
import 'package:vitta_case_mobile/core/widgets/responsiveness.dart';
import 'package:vitta_case_mobile/features/movies/presentation/pages/detailed_movie/detailed_movie_page.dart';

class MovieCoverPoster extends StatelessWidget {
  const MovieCoverPoster({Key key, @required this.widget}) : super(key: key);

  final DetailedMoviePage widget;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.detailedMovieParams.baseImage,
      height: deviceSize(context).height,
      fit: BoxFit.cover,
    );
  }
}
