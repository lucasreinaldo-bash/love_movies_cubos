import 'package:lovemoviescubos/models/atores_model.dart';
import 'package:lovemoviescubos/models/filmes_model.dart';
import 'package:lovemoviescubos/models/genero_model.dart';

class GeneroResponse {
  final List<GeneroModel> genero;
  final String error;

  GeneroResponse(this.genero, this.error);

  GeneroResponse.fromJson(Map<String, dynamic> json)
      : genero = (json["results"] as List)
            .map((e) => new GeneroModel.fromJson(e))
            .toList(),
        error = "";

  GeneroResponse.withError(String errorValue)
      : genero = List(),
        error = errorValue;
}
