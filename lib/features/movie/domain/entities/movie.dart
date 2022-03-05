import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  int? id;
  String? posterPath;
  String? title;
  String? overview;

  Movie({this.id, this.overview, this.title, this.posterPath});

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
