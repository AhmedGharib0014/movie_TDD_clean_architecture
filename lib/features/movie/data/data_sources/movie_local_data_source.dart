import 'package:movie_app/core/use_cases/use_cases_params_use_case_contract.dart';
import 'package:movie_app/features/movie/data/models/movie_model.dart';

abstract class MovieLocalDataSource {
  Future<List<MovieModel>?> getCachedMovies(Params? params);
  Future<void> cachMovies(List<MovieModel> movies);
}
