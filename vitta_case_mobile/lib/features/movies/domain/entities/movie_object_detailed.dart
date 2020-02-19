import 'package:meta/meta.dart';

class MovieDetailed {
  MovieDetailed(
      {@required this.title,
      @required this.releasedDate,
      @required this.description,
      @required this.moviePoster,
      @required this.director,
      @required this.genre});

  final String title;
  final String releasedDate;
  final String description;
  final String genre;
  final String moviePoster;
  final String director;
}
