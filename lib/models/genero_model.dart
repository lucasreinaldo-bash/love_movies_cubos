class GeneroModel {
  final int id;
  final String name;

  GeneroModel(this.id, this.name);

  GeneroModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"];
}
