import 'dart:convert';

List<FilmesModel> employeeFromJson(String str) => List<FilmesModel>.from(
    json.decode(str).map((x) => FilmesModel.fromJson(x)));

String employeeToJson(List<FilmesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FilmesModel {
  bool adult;
  String backdropPath;
  Null belongsToCollection;
  int budget;
  List<Genres> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompanies> productionCompanies;
  List<ProductionCountries> productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguages> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  FilmesModel({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory FilmesModel.fromJson(Map<String, dynamic> json) => FilmesModel(
        id: json["id"],
        adult: json["adult"],
        backdropPath: json['backdrop_path'],
        belongsToCollection: json['belongs_to_collection'],
        budget: json['budget'],
        homepage: json['homepage'],
        imdbId: json['imdb_id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        releaseDate: json['release_date'],
        revenue: json['revenue'],
        runtime: json['runtime'],
        status: json['status'],
        tagline: json['tagline'],
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'],
        voteCount: json['vote_count'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

class Genres {
  int id;
  String name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ProductionCompanies {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  ProductionCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logoPath = json['logo_path'];
    name = json['name'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo_path'] = this.logoPath;
    data['name'] = this.name;
    data['origin_country'] = this.originCountry;
    return data;
  }
}

class ProductionCountries {
  String iso31661;
  String name;

  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json) {
    iso31661 = json['iso_3166_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_3166_1'] = this.iso31661;
    data['name'] = this.name;
    return data;
  }
}

class SpokenLanguages {
  String iso6391;
  String name;

  SpokenLanguages({this.iso6391, this.name});

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    iso6391 = json['iso_639_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_639_1'] = this.iso6391;
    data['name'] = this.name;
    return data;
  }
}
