import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/errors/error_contact.dart';
import 'package:movie_app/core/resources/strings.dart';
import 'package:movie_app/core/use_cases/use_cases_params_use_case_contract.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/domain/usecases/get_movies_use_case.dart';
import 'package:movie_app/features/movie/presentation/movies_list_vloc/movies_list_bloc.dart';

import 'movies_list_bloc_test.mocks.dart';

@GenerateMocks([GetMoviesUseCase])
void main() {
  late MockGetMoviesUseCase getMoviesUseCase;
  late MoviesListBloc moviesListBloc;

  setUp(() {
    getMoviesUseCase = MockGetMoviesUseCase();
    moviesListBloc = MoviesListBloc(getMoviesUseCase);
  });

  group("test getting data", () {
    List<Movie>? movies = [
      Movie(id: 0, title: "movie0"),
      Movie(id: 1, title: "movie1")
    ];
    blocTest("should emit initstate",
        build: () => moviesListBloc,
        verify: (MoviesListBloc bloc) => bloc.state is MoviesListInitial);

    blocTest("should emit loading then success if every thing goes as expected",
        build: () => moviesListBloc,
        act: (MoviesListBloc bloc) {
          when(getMoviesUseCase.call((any)))
              .thenAnswer((_) async => Right(movies));
          bloc.add(MoviesListFetch());
        },
        verify: (bloc) {
          verify(getMoviesUseCase.call((any)));
        },
        expect: () => [MoviesListLoading(), MoviesListSucess(movies: movies)]);

    blocTest("should emit failure in case of server exception",
        build: () => moviesListBloc,
        act: (MoviesListBloc bloc) {
          when(getMoviesUseCase.call((any))).thenAnswer(
              (_) async => Left(ServerFailure(SERVER_EXCEPTION_MSG)));
          bloc.add(MoviesListFetch());
        },
        verify: (bloc) {
          verify(getMoviesUseCase.call((any)));
        },
        expect: () => [
              MoviesListLoading(),
              const MoviesListFailure(error: SERVER_EXCEPTION_MSG)
            ]);

    blocTest("should emit failure in case of cache exception",
        build: () => moviesListBloc,
        act: (MoviesListBloc bloc) {
          when(getMoviesUseCase.call((any))).thenAnswer(
              (_) async => Left(ServerFailure(CACHE_EXCEPTION_MSG)));
          bloc.add(MoviesListFetch());
        },
        verify: (bloc) {
          verify(getMoviesUseCase.call((any)));
        },
        expect: () => [
              MoviesListLoading(),
              const MoviesListFailure(error: CACHE_EXCEPTION_MSG)
            ]);
  });
}
