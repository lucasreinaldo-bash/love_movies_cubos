import 'package:lovemoviescubos/models/atores_model.dart';
import 'package:lovemoviescubos/models/filmes_model.dart';

class AtoresResponse {
  final List<AtoresModel> atores;
  final String error;

  AtoresResponse(this.atores, this.error);

  AtoresResponse.fromJson(Map<String, dynamic> json)
      : atores = (json["results"] as List)
            .map((e) => new AtoresModel.fromJson(e))
            .toList(),
        error = "";

  AtoresResponse.withError(String errorValue)
      : atores = List(),
        error = errorValue;
}
