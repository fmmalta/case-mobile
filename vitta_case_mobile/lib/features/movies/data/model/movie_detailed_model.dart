import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object_detailed.dart';

class MovieDetailedModel extends MovieDetailed {
  MovieDetailedModel(
      {this.title,
      this.releasedDate,
      this.description,
      this.moviePoster,
      this.director,
      this.genre})
      : super(
            title: title,
            releasedDate: releasedDate,
            director: director,
            description: description,
            genre: genre,
            moviePoster: moviePoster);

  final String title;
  final String releasedDate;
  final String description;
  final String moviePoster;
  final String genre;
  final String director;

  factory MovieDetailedModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailedModel(
        title: json['Title'],
        genre: json['Genre'],
        director: json['Director'],
        releasedDate: json['Released'],
        moviePoster: json['Poster'],
        description: json['Plot']);
  }
}
