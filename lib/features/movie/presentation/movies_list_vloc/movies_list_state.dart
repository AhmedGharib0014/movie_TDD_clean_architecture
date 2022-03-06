part of 'movies_list_bloc.dart';

abstract class MoviesListState extends Equatable {
  const MoviesListState();

  @override
  List<Object> get props => [];
}

class MoviesListInitial extends MoviesListState {}

class MoviesListSucess extends MoviesListState {
  final List<Movie> movies;
  const MoviesListSucess({required this.movies});
  @override
  List<Object> get props => [movies];
}

class MoviesListLoading extends MoviesListState {}

class MoviesListFailure extends MoviesListState {
  final String? error;
  const MoviesListFailure({required this.error});
  @override
  List<Object> get props => [error ?? ''];
}
