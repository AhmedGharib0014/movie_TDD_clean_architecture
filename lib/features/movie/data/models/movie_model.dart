import 'package:movie_app/features/movie/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel([id, title, overview, posterPath])
      : super(id: id, title: title, overview: overview, posterPath: posterPath);
  factory MovieModel.fromJson(Map<String, dynamic> map) {
    return MovieModel(
        map['id'], map['title'], map['overview'], map['poster_path']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "title": title,
      "overview": overview,
      "poster_path": posterPath
    };
  }
}
