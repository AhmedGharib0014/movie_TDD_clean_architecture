import 'package:flutter/foundation.dart';
import 'package:movie_app/core/errors/error_contact.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/core/use_cases/use_case_contact.dart';
import 'package:movie_app/core/use_cases/use_cases_params_contact.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/domain/repository/movies_repository.dart';

class GetMoviesUseCase extends UseCasesContact<List<Movie>?, NoParams> {
  MoviesRepository moviesRepository;
  GetMoviesUseCase({required this.moviesRepository});

  @override
  Future<Either<Failure, List<Movie>?>> call(NoParams? params) {
    return moviesRepository.getMoviesList(params);
  }
}
