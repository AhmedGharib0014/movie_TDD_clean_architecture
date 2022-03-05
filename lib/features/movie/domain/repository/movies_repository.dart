import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/error_contact.dart';
import 'package:movie_app/core/use_cases/use_cases_params_contact.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<Movie>?>> getMoviesList(Params? params);
}
