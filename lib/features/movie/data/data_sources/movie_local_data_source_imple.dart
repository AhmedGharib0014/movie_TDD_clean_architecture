import 'dart:convert';

import 'package:movie_app/core/errors/chache_exception.dart';
import 'package:movie_app/core/use_cases/use_cases_params_contact.dart';
import 'package:movie_app/features/movie/data/data_sources/movie_local_data_source.dart';
import 'package:movie_app/features/movie/data/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String CACHE_MOVIES_KEY = "cash movies key";

class MovieLocalDateSourceImple extends MovieLocalDataSource {
  MovieLocalDateSourceImple({required this.sharedPreferences});

  SharedPreferences sharedPreferences;

  @override
  Future<void> cachMovies(List<MovieModel> movies) async {
    await sharedPreferences.setStringList(
        CACHE_MOVIES_KEY, movies.map((e) => jsonEncode(e.toJson())).toList());
    return;
  }

  @override
  Future<List<MovieModel>?> getCachedMovies(Params? params) {
    try {
      List<MovieModel>? cachedMovies = sharedPreferences
          .getStringList(CACHE_MOVIES_KEY)
          ?.map<MovieModel>((e) => MovieModel.fromJson(jsonDecode(e)))
          .toList();
      return Future.value(cachedMovies);
    } catch (e) {
      throw CacheException();
    }
  }
}
