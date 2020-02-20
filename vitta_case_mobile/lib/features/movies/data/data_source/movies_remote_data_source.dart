import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:vitta_case_mobile/core/error/exceptions.dart';
import 'package:vitta_case_mobile/features/movies/data/model/movie_detailed_model.dart';
import 'package:vitta_case_mobile/features/movies/data/model/movie_model.dart';
import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object.dart';

abstract class MoviesRemoteDataSource {
  Future<List<Movie>> searchedMovie(String query);

  Future<MovieDetailedModel> getDetailedMovie(String movieID);
}

class MovieRemoteDataSourceImpl implements MoviesRemoteDataSource {
  MovieRemoteDataSourceImpl({@required this.client});

  final http.Client client;

  @override
  Future<List<Movie>> searchedMovie(String query) async {
    final Map<String, String> _headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final http.Response response = await client.get(
        'http://www.omdbapi.com/?apikey=d12b4be8&s=$query&type=movie',
        headers: _headers);

    final result = json.decode(response.body);
    print('JSON Result: $result');
    if (response.statusCode == 200 && result['Response'] == 'True') {
      print('Response: ${result['Response']}');
      final moviesFound = result['Search'];
      final List<Movie> _movies = <Movie>[];
      for (dynamic movie in moviesFound)
        _movies.add(MovieModel.fromJson(movie));
      return _movies;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailedModel> getDetailedMovie(String movieID) async {
    final Map<String, String> _headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final http.Response response = await http.get(
        'http://www.omdbapi.com/?apikey=d12b4be8&i=$movieID',
        headers: _headers);
    final result = json.decode(response.body);
    print(result);
    if (response.statusCode == 200 && result['Response'] == 'True') {
      return MovieDetailedModel.fromJson(result);
    } else {
      throw ServerException();
    }
  }
}
