import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/errors/server_exception.dart';
import 'package:movie_app/core/resources/env_variables.dart';
import 'package:movie_app/core/use_cases/use_cases_params_contact.dart';
import 'package:movie_app/features/movie/data/data_sources/movie_remote_date_source_imple.dart';
import 'package:movie_app/features/movie/data/models/movie_model.dart';

import '../../../../core/fixture/fixure_reader.dart';
import 'movie_remote_data_source_imple_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late MovieRemoteDataSourceImple movieRemoteDataSourceImple;

  setUp(() {
    mockClient = MockClient();
    movieRemoteDataSourceImple = MovieRemoteDataSourceImple(mockClient);
  });

  group("getMovies", () {
    String response = readFixture('movies_response.json');
    List<MovieModel> movies = [
      MovieModel(0, "test", "test", "test"),
      MovieModel(1, "test", "test", "test"),
    ];

    test("test calling api eith right header", () async {
      when(mockClient.get(
              Uri.parse('https://api.themoviedb.org/3/movie/popular'),
              headers: {'language': 'en-US', 'api_key': API_KEY}))
          .thenAnswer((_) async => http.Response(response, 200));
      var result = await movieRemoteDataSourceImple.getMovies(NoParams());
      verify(mockClient.get(
          Uri.parse('https://api.themoviedb.org/3/movie/popular'),
          headers: {'language': 'en-US', 'api_key': API_KEY}));
    });

    test("should return list of movies when calling api succeded", () async {
      when(mockClient.get(
              Uri.parse('https://api.themoviedb.org/3/movie/popular'),
              headers: {'language': 'en-US', 'api_key': API_KEY}))
          .thenAnswer((_) async => http.Response(response, 200));
      var result = await movieRemoteDataSourceImple.getMovies(NoParams());

      expect(result, movies);
    });

    test("should through server exception when any failure happened", () async {
      when(mockClient.get(
              Uri.parse('https://api.themoviedb.org/3/movie/popular'),
              headers: {'language': 'en-US', 'api_key': API_KEY}))
          .thenThrow(ServerException());
      final call = movieRemoteDataSourceImple.getMovies;
      expect(() => call(NoParams()),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
