class AtoresModel {
  final int id;
  final String name, popularity, profileImg, known;

  AtoresModel(
    this.id,
    this.name,
    this.profileImg,
    this.known,
    this.popularity,
  );

  AtoresModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"],
        name = json["name"],
        profileImg = json["profile_path"].toDouble(),
        known = json["known_for_department"];
}
