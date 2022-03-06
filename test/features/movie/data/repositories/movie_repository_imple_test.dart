import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/errors/chache_exception.dart';
import 'package:movie_app/core/errors/error_contact.dart';
import 'package:movie_app/core/errors/server_exception.dart';
import 'package:movie_app/core/network/networkInfo.dart';
import 'package:movie_app/core/resources/strings.dart';
import 'package:movie_app/core/use_cases/use_cases_params_contact.dart';
import 'package:movie_app/features/movie/data/data_sources/movie_local_data_source.dart';
import 'package:movie_app/features/movie/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/features/movie/data/models/movie_model.dart';
import 'package:movie_app/features/movie/data/repositories/movies-repositories_imple.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';

import 'movie_repository_imple_test.mocks.dart';

@GenerateMocks([MovieRemoteDataSource, MovieLocalDataSource, NetWorkInfo])
void main() {
  late MovieRepositoryImple movieRepositoryImple;
  late NetWorkInfo netWorkInfo;
  late MovieRemoteDataSource movieRemoteDataSource;
  late MovieLocalDataSource movieLocalDataSource;

  setUp(() {
    movieRemoteDataSource = MockMovieRemoteDataSource();
    movieLocalDataSource = MockMovieLocalDataSource();
    netWorkInfo = MockNetWorkInfo();
    movieRepositoryImple = MovieRepositoryImple(
        movieRemoteDataSource: movieRemoteDataSource,
        netWorkInfo: netWorkInfo,
        movieLocalDataSource: movieLocalDataSource);
  });

  group("getMoviesList", () {
    List<MovieModel> movies = [
      MovieModel(0, "test", "test", "test"),
      MovieModel(1, "test", "test", "test")
    ];
    test("should check internet connection", () async {
      when(netWorkInfo.isConnected).thenAnswer((realInvocation) async => true);
      when(movieRemoteDataSource.getMovies(any))
          .thenAnswer((_) async => Future.value(movies));
      await movieRepositoryImple.getMoviesList(NoParams());
      verify(netWorkInfo.isConnected);
    });

    group("online model", () {
      test("should call movieRemoteDateSource to fetch movies from  server",
          () async {
        when(netWorkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
        when(movieRemoteDataSource.getMovies(any))
            .thenAnswer((_) async => Future.value(movies));
        var result = await movieRepositoryImple.getMoviesList(NoParams());
        verify(movieRemoteDataSource.getMovies(any));
        expect(result, Right(movies));
      });

      test(
          "should call movieLocalDataSource to cahche movies after success fetching it from server",
          () async {
        when(netWorkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
        when(movieRemoteDataSource.getMovies(any))
            .thenAnswer((_) async => Future.value(movies));
        await movieRepositoryImple.getMoviesList(NoParams());
        verify(movieLocalDataSource.cachMovies(movies));
      });

      test("should catch server exception  when failing to get data", () async {
        when(netWorkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
        when(movieRemoteDataSource.getMovies(any)).thenThrow(ServerException());
        var result = await movieRepositoryImple.getMoviesList(NoParams());

        verify(movieRemoteDataSource.getMovies(any));
        verifyNoMoreInteractions(movieLocalDataSource);
        expect(result, equals(Left(ServerFailure(SERVER_EXCEPTION_MSG))));
      });
    });
    group("offline mode ", () {
      test('should call movieLocalDateSource to fetch cached movies', () async {
        when(netWorkInfo.isConnected)
            .thenAnswer((realInvocation) async => false);
        when(movieLocalDataSource.getCachedMovies(any))
            .thenAnswer((_) async => movies);

        var result = await movieRepositoryImple.getMoviesList(NoParams());
        verify(movieLocalDataSource.getCachedMovies(any));
        verifyNoMoreInteractions(movieRemoteDataSource);
        expect(result, Right(movies));
      });

      test('should through cache exception when failing to get cached movies',
          () async {
        when(netWorkInfo.isConnected)
            .thenAnswer((realInvocation) async => false);
        when(movieLocalDataSource.getCachedMovies(any))
            .thenThrow(CacheException());

        var result = await movieRepositoryImple.getMoviesList(NoParams());
        verify(movieLocalDataSource.getCachedMovies(any));
        verifyNoMoreInteractions(movieRemoteDataSource);
        expect(result, equals(Left(CacheFailure(CACHE_EXCEPTION_MSG))));
      });
    });
  });
}
