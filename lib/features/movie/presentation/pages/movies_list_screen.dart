import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/dependency_container.dart';
import 'package:movie_app/features/movie/presentation/movies_list_vloc/movies_list_bloc.dart';
import 'package:movie_app/features/movie/presentation/widgets%20/Movie_card.dart';
import 'package:movie_app/features/movie/presentation/widgets%20/empty_state_widget.dart';
import 'package:movie_app/features/movie/presentation/widgets%20/loading_widget.dart';

class MoviesListScreen extends StatefulWidget {
  const MoviesListScreen({Key? key}) : super(key: key);

  @override
  State<MoviesListScreen> createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  late MoviesListBloc moviesListBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesListBloc = getIt<MoviesListBloc>()..add(MoviesListFetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('movies'),
      ),
      body: BlocBuilder(
        bloc: moviesListBloc,
        builder: (context, state) {
          if (state is MoviesListInitial) {
            return const EmptyStateScreen(
              msg: "init state",
            );
          }
          if (state is MoviesListFailure) {
            return EmptyStateScreen(
              msg: state.error ?? '',
            );
          }
          if (state is MoviesListSucess) {
            if (state.movies.isEmpty) {
              return const EmptyStateScreen(
                msg: "empty state",
              );
            } else {
              return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) =>
                      MovieCard(movie: state.movies[index]));
            }
          }

          return const LoadingWidget();
        },
      ),
    );
  }
}
