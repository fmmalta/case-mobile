import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object_detailed.dart';

class MovieDetailedModel extends MovieDetailed {
  MovieDetailedModel(
      {this.title, this.releasedDate, this.description, this.moviePoster})
      : super(
            title: title,
            releasedDate: releasedDate,
            description: description,
            moviePoster: moviePoster);

  final String title;
  final String releasedDate;
  final String description;
  final String moviePoster;

  factory MovieDetailedModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailedModel(
        title: json['Title'],
        releasedDate: json['Released'],
        moviePoster: json['Poster'],
        description: json['Plot']);
  }
}
