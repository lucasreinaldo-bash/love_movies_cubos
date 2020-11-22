import 'package:dio/dio.dart';
import 'package:lovemoviescubos/models/atores_response.dart';
import 'package:lovemoviescubos/models/genero_response.dart';
import 'package:lovemoviescubos/models/response_filme.dart';

class FilmesRepository {
  final String apiKey = "73d0e926f349bfb4d8211828e4292640";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();

  var getPopularUrl = "$mainUrl/movie/top_rated";
  var getMoviesUrl = "$mainUrl/discover/movie";
  var getPlayingUrl = "$mainUrl/movie/now_playing";
  var getGeneroUrl = "$mainUrl/genre/movie/list";
  var getPersonagensUrl = "$mainUrl/trending/person/week";

  Future<FilmeResponse> getFilmes() async {
    var params = {"api_key": apiKey, "language": "en-US", "page:": 1};

    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);
      return FilmeResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception ocurred: $error stacktrace: $stacktrace");
      return FilmeResponse.withError("$error");
    }
  }

  Future<FilmeResponse> getPlayingFilmes() async {
    var params = {"api_key": apiKey, "language": "en-US", "page:": 1};

    try {
      Response response =
          await _dio.get(getPlayingUrl, queryParameters: params);
      return FilmeResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception ocurred: $error stacktrace: $stacktrace");
      return FilmeResponse.withError("$error");
    }
  }

  Future<FilmeResponse> getPopulares() async {
    var params = {"api_key": apiKey, "language": "en-US", "page:": 1};

    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);
      return FilmeResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception ocurred: $error stacktrace: $stacktrace");
      return FilmeResponse.withError("$error");
    }
  }

  Future<AtoresResponse> getAtores() async {
    var params = {
      "api_key": apiKey,
    };

    try {
      Response response =
          await _dio.get(getPersonagensUrl, queryParameters: params);
      return AtoresResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception ocurred: $error stacktrace: $stacktrace");
      return AtoresResponse.withError("$error");
    }
  }

  Future<GeneroResponse> getGenero() async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page:": 1,
    };

    try {
      Response response = await _dio.get(getGeneroUrl, queryParameters: params);
      return GeneroResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception ocurred: $error stacktrace: $stacktrace");
      return GeneroResponse.withError("$error");
    }
  }

  Future<FilmeResponse> getFilmesPorGenero(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en-US",
      "page:": 1,
      "with_genres": id
    };

    try {
      Response response = await _dio.get(getGeneroUrl, queryParameters: params);
      return FilmeResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception ocurred: $error stacktrace: $stacktrace");
      return FilmeResponse.withError("$error");
    }
  }
}
