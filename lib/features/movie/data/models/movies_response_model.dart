import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movie/data/models/movie_model.dart';

class MoviesResponseModel extends Equatable {
  List<MovieModel>? results;

  MoviesResponseModel({this.results});

  factory MoviesResponseModel.fromJson(Map<String, dynamic> map) {
    return MoviesResponseModel(
        results: ((map['results'] ?? []) as List)
            .map((e) => MovieModel.fromJson(e))
            .toList());
  }

  @override
  // TODO: implement props
  List<Object?> get props => [results];
}
