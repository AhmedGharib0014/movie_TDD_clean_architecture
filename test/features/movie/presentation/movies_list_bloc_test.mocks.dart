// Mocks generated by Mockito 5.1.0 from annotations
// in movie_app/test/features/movie/presentation/movies_list_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie_app/core/errors/error_contact.dart' as _i6;
import 'package:movie_app/core/use_cases/use_cases_params_contact.dart' as _i8;
import 'package:movie_app/features/movie/domain/entities/movie.dart' as _i7;
import 'package:movie_app/features/movie/domain/repository/movies_repository.dart'
    as _i2;
import 'package:movie_app/features/movie/domain/usecases/get_movies_use_case.dart'
    as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeMoviesRepository_0 extends _i1.Fake implements _i2.MoviesRepository {
}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetMoviesUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMoviesUseCase extends _i1.Mock implements _i4.GetMoviesUseCase {
  MockGetMoviesUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MoviesRepository get moviesRepository =>
      (super.noSuchMethod(Invocation.getter(#moviesRepository),
          returnValue: _FakeMoviesRepository_0()) as _i2.MoviesRepository);
  @override
  set moviesRepository(_i2.MoviesRepository? _moviesRepository) => super
      .noSuchMethod(Invocation.setter(#moviesRepository, _moviesRepository),
          returnValueForMissingStub: null);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.Movie>?>> call(
          _i8.NoParams? params) =>
      (super.noSuchMethod(Invocation.method(#call, [params]),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.Movie>?>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.Movie>?>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.Movie>?>>);
}
