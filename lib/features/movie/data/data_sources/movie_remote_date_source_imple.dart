import 'dart:convert';

import 'package:movie_app/core/errors/server_exception.dart';
import 'package:movie_app/core/resources/env_variables.dart';
import 'package:movie_app/core/use_cases/use_cases_params_contact.dart';
import 'package:movie_app/features/movie/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/features/movie/data/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/features/movie/data/models/movies_response_model.dart';

class MovieRemoteDataSourceImple extends MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImple(this.client);

  @override
  Future<List<MovieModel>?> getMovies(Params? params) async {
    try {
      var response = await client.get(
          Uri.parse('https://api.themoviedb.org/3/movie/popular'),
          headers: {'language': 'en-US', 'api_key': API_KEY});
      return MoviesResponseModel.fromJson(jsonDecode(response.body)).results;
    } catch (e) {
      throw ServerException();
    }
  }
}
