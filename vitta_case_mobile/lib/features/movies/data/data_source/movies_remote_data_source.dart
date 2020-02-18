import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:vitta_case_mobile/core/error/exceptions.dart';
import 'package:vitta_case_mobile/features/movies/data/model/movie_detailed_model.dart';
import 'package:vitta_case_mobile/features/movies/data/model/movie_model.dart';
import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object.dart';
import 'package:vitta_case_mobile/features/movies/domain/entities/movie_object_detailed.dart';

abstract class MoviesRemoteDataSource {
  Future<Movie> searchedMovie(String query);

  Future<MovieDetailed> getDetailedMovie(String movieID);
}

class MovieRemoteDataSourceImpl implements MoviesRemoteDataSource {
  MovieRemoteDataSourceImpl({@required this.client});

  final http.Client client;

  @override
  Future<Movie> searchedMovie(String query) async {
    final Map<String, String> _headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final http.Response response = await client.get(
        'http://www.omdbapi.com/?apikey=d12b4be8&s=$query&type=movie',
        headers: _headers);

    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['Response']) {
      print('Response: ${result['Response']}');
      return MovieModel.fromJson(result);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailed> getDetailedMovie(String movieID) async {
    final Map<String, String> _headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final http.Response response = await http.get(
        'http://www.omdbapi.com/?apikey=d12b4be8&i=$movieID',
        headers: _headers);
    final result = json.decode(response.body);

    if (response.statusCode == 200 && result['Response']) {
      return MovieDetailedModel.fromJson(result);
    } else {
      throw ServerException();
    }
  }
}
