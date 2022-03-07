import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/errors/chache_exception.dart';
import 'package:movie_app/core/use_cases/use_cases_params_use_case_contract.dart';
import 'package:movie_app/features/movie/data/data_sources/movie_local_data_source_imple.dart';
import 'package:movie_app/features/movie/data/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'movie_local_date_source_imple_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late MovieLocalDateSourceImple movieLocalDataImple;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    movieLocalDataImple =
        MovieLocalDateSourceImple(sharedPreferences: mockSharedPreferences);
  });

  group("CacheMovies", () {
    List<MovieModel> movies = [
      MovieModel(0, "test", "test", "test"),
      MovieModel(1, "test", "test", "test"),
    ];
    test("should use sharedprefernces to save last fetched data", () async {
      when(mockSharedPreferences.setStringList(CACHE_MOVIES_KEY,
              movies.map((e) => jsonEncode(e.toJson())).toList()))
          .thenAnswer((realInvocation) async => true);
      await movieLocalDataImple.cachMovies(movies);
      verify(mockSharedPreferences.setStringList(CACHE_MOVIES_KEY,
          movies.map((e) => jsonEncode(e.toJson())).toList()));
    });
  });

  group("getachechedMovies", () {
    List<MovieModel> movies = [
      MovieModel(0, "test", "test", "test"),
      MovieModel(1, "test", "test", "test"),
    ];
    test("should use sharedprefernces to fetch last cached data", () async {
      when(mockSharedPreferences.getStringList(
        CACHE_MOVIES_KEY,
      )).thenAnswer((_) => movies.map((e) => jsonEncode(e.toJson())).toList());
      var result = await movieLocalDataImple.getCachedMovies(NoParams());
      verify(mockSharedPreferences.getStringList(CACHE_MOVIES_KEY));
      expect(result, movies);
    });

    test("should though cache exception when any error happened", () async {
      when(mockSharedPreferences.getStringList(
        CACHE_MOVIES_KEY,
      )).thenThrow(CacheException());
      var call = movieLocalDataImple.getCachedMovies;
      expect(
          () => call(NoParams()), throwsA(const TypeMatcher<CacheException>()));
    });
  });
}
