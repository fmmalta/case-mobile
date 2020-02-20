import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object.dart';

class MovieModel extends Movie {
  MovieModel({this.title, this.year, this.movieID, this.moviePoster})
      : super(
            title: title,
            year: year,
            movieID: movieID,
            moviePoster: moviePoster);

  final String title;
  final String year;
  final String movieID;
  final String moviePoster;

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        title: json['Title'],
        year: json['Year'],
        movieID: json['imdbID'],
        moviePoster: json['Poster']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'Title': title,
        'Year': year,
        'ID': movieID,
        'Poster': moviePoster,
      };
}
