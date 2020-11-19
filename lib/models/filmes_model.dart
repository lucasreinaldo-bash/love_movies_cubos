class FilmeModel {
  final int id;
  final String title, popularity, poster, overview, rating, backPoster;

  FilmeModel(this.id, this.title, this.backPoster, this.overview,
      this.popularity, this.poster, this.rating);

  FilmeModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularityu"],
        title = json["title"],
        rating = json["vote_average"].toDouble(),
        backPoster = json["backdrop_path"],
        poster = json["poster_path"],
        overview = json["overview"];
}
