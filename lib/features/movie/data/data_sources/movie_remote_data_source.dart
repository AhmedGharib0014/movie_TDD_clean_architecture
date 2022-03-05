import 'package:dartz/dartz.dart';
import 'package:movie_app/core/errors/error_contact.dart';
import 'package:movie_app/core/use_cases/use_cases_params_contact.dart';
import 'package:movie_app/features/movie/data/models/movie_model.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';

abstract class MovieRemoteDataSource {
  Future<Either<Failure, List<MovieModel>>> getMovies(Params params);
}
