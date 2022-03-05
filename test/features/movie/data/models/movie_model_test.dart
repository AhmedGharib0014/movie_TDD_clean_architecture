import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/features/movie/data/models/movie_model.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';

import '../../../../core/fixture/fixure_reader.dart';

void main() {
  late MovieModel movieModel;
  setUp(() {
    movieModel = MovieModel();
  });

  group("movieModel", () {
    String movieString = readFixture("movie.json");
    MovieModel model = MovieModel()
      ..id = 0
      ..overview = "test"
      ..posterPath = "test"
      ..title = "test";

    test("should be subtype of movie", () {
      expect(movieModel, isA<Movie>());
    });

    test("should  return movie model from json string", () {
      var result = MovieModel.fromJson(jsonDecode(movieString));
      expect(result, model);
    });

    test("should convert movie model to json string", () {
      var result = model.toJson();
      expect(result, jsonDecode(movieString));
    });
  });
}
