import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/features/movie/data/models/movie_model.dart';
import 'package:movie_app/features/movie/data/models/movies_response_model.dart';

import '../../../../core/fixture/fixure_reader.dart';

void main() {
  late MoviesResponseModel moviesResponseModel;
  setUp(() {
    moviesResponseModel = MoviesResponseModel();
  });

  group("moviesResponseModel", () {
    String moviesResponseString = readFixture("movies_response.json");
    MoviesResponseModel model = MoviesResponseModel(results: [
      MovieModel(0, "test", "test", "test"),
      MovieModel(1, "test", "test", "test"),
    ]);
    test("should reeturn MoviesResponseModel  from json string", () {
      var result =
          MoviesResponseModel.fromJson(jsonDecode(moviesResponseString));
      expect(result, model);
    });
  });
}
