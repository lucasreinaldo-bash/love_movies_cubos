import 'package:lovemoviescubos/models/filmes_model.dart';

class FilmeResponse {
  final List<FilmeModel> filmes;
  final String error;

  FilmeResponse(this.filmes, this.error);

  FilmeResponse.fromJson(Map<String, dynamic> json)
      : filmes = (json["results"] as List)
            .map((e) => new FilmeModel.fromJson(e))
            .toList(),
        error = "";

  FilmeResponse.withError(String errorValue)
      : filmes = List(),
        error = errorValue;
}
