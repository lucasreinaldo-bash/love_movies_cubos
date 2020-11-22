import 'package:cloud_firestore/cloud_firestore.dart';

class FilmesData {
  String backdropPath;
  String idDocument;
  List genres;
  String homepage;
  bool adult;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  FilmesData.fromDocument(DocumentSnapshot snapshot) {
    idDocument = snapshot.id;
    id = snapshot.get("id");
    adult = snapshot.get("adult");
    backdropPath = snapshot.get("backdrop_path");
    genres = snapshot.get("genre_ids");
    originalLanguage = snapshot.get("original_language");
    originalTitle = snapshot.get("original_title");
    overview = snapshot.get("overview");
    popularity = snapshot.get("popularity");
    posterPath = snapshot.get("poster_path");
    releaseDate = snapshot.get("release_date");
    title = snapshot.get("title");
    voteAverage = double.parse(snapshot.get("vote_average").toString());
    voteCount = snapshot.get("vote_count");
  }

  Map<String, dynamic> toResumedMap() {
    return {
      "id": id,
      "backdrop_path": backdropPath,
      "genre_ids": genres,
      "adult": adult,
      "original_anguage": originalLanguage,
      "original_title": originalTitle,
      "overview": overview,
      "popularity": popularity,
      "poster_path": posterPath,
      "release_date": releaseDate,
      "title": title,
      "vote_average": voteAverage,
      "vote_count": voteCount,
    };
  }
}
