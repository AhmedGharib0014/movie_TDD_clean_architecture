import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/use_cases/use_cases_params_use_case_contract.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/domain/repository/movies_repository.dart';
import 'package:movie_app/features/movie/domain/usecases/get_movies_use_case.dart';

import 'get_movies_list_test.mocks.dart';

@GenerateMocks([MoviesRepository])
void main() {
  late GetMoviesUseCase getMoviesUseCase;
  late MockMoviesRepository moviesRepository;

  setUp(() {
    moviesRepository = MockMoviesRepository();
    getMoviesUseCase = GetMoviesUseCase(moviesRepository: moviesRepository);
  });

  test(
      "getMoviesUseCase should  call movies repository function  to fetch  movies",
      () async {
    List<Movie>? movies = [
      Movie(id: 0, title: "movie0"),
      Movie(id: 1, title: "movie1")
    ];
    // arrange
    when(moviesRepository.getMoviesList(any))
        .thenAnswer((_) async => Right(movies));
    // act
    var answer = await getMoviesUseCase(NoParams());
    // verify
    expect(answer, equals(Right(movies)));
    verify(moviesRepository.getMoviesList(any));
    verifyNoMoreInteractions(moviesRepository);
  });
}
