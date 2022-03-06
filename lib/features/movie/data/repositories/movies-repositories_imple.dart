import 'package:flutter/material.dart';
import 'package:movie_app/core/errors/chache_exception.dart';
import 'package:movie_app/core/errors/server_exception.dart';
import 'package:movie_app/core/network/networkInfo.dart';
import 'package:movie_app/core/resources/strings.dart';
import 'package:movie_app/features/movie/data/data_sources/movie_local_dtat_source.dart';
import 'package:movie_app/features/movie/data/data_sources/movie_remote_data_source.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/core/use_cases/use_cases_params_contact.dart';
import 'package:movie_app/core/errors/error_contact.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/features/movie/domain/repository/movies_repository.dart';

class MovieRepositoryImple extends MoviesRepository {
  MovieRepositoryImple(
      {required this.movieLocalDataSource,
      required this.netWorkInfo,
      required this.movieRemoteDataSource});
  MovieRemoteDataSource movieRemoteDataSource;
  MovieLocalDataSource movieLocalDataSource;
  NetWorkInfo netWorkInfo;

  @override
  Future<Either<Failure, List<Movie>?>> getMoviesList(Params? params) async {
    if (await netWorkInfo.isConnected == true) {
      try {
        var movies = await movieRemoteDataSource.getMovies(NoParams());
        await movieLocalDataSource.cachMovies(movies!);
        return Right(movies);
      } on ServerException {
        return Left(ServerFailure(SERVER_EXCEPTION_MSG));
      }
    } else {
      try {
        var movies = await movieLocalDataSource.getCachedMovies(NoParams());
        return Right(movies);
      } on CacheException {
        return Left(CacheFailure(CACHE_EXCEPTION_MSG));
      }
    }
  }
}
