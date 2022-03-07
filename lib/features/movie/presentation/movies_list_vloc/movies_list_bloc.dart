import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/errors/error_contact.dart';
import 'package:movie_app/core/use_cases/use_cases_params_use_case_contract.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/domain/usecases/get_movies_use_case.dart';

part 'movies_list_event.dart';
part 'movies_list_state.dart';

class MoviesListBloc extends Bloc<MoviesListEvent, MoviesListState> {
  final GetMoviesUseCase getMoviesUseCase;
  MoviesListBloc(this.getMoviesUseCase) : super(MoviesListInitial()) {
    on<MoviesListFetch>(_fetchMovies);
  }

  FutureOr<void> _fetchMovies(
      MoviesListFetch event, Emitter<MoviesListState> emit) async {
    emit(MoviesListLoading());

    Either<Failure, List<Movie>?> result = await getMoviesUseCase(NoParams());
    await result.fold<FutureOr>((l) {
      emit(MoviesListFailure(error: l.errorMessaeg));
    }, (right) async {
      emit(MoviesListSucess(movies: right!));
    });
  }
}
