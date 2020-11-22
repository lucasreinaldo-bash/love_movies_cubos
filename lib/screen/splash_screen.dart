import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lovemoviescubos/models/genero_model.dart';
import 'package:lovemoviescubos/models/movie_model.dart';
import 'package:lovemoviescubos/repository/repository.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FilmesRepository repository = FilmesRepository();

  @override
  void initState() {
    super.initState();
    uploaderFilmes();
    uploaderGenero();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 200,
              height: 200,
              child: Center(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 200,
                        width: 200,
                        child: FlareActor(
                          "assets/loveanimated.flr",
                          alignment: Alignment.center,
                          fit: BoxFit.contain,
                          animation: "Alarm",
                        ),
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  uploaderFilmes() async {
    Random random = new Random();
    int randomNumber = random.nextInt(400);
    var urlFilmes =
        "https://api.themoviedb.org/3/movie/now_playing?api_key=${repository.apiKey}&language=pt-BR&page=${randomNumber}";

    Response response = await Dio().get(urlFilmes);

    List<MovieModel> filmes = List<MovieModel>();

    for (Map<String, dynamic> item in response.data["results"]) {
      filmes.add(MovieModel.fromJson(item));

      var snapshots = await FirebaseFirestore.instance
          .collection("Filmes")
          .document(item["title"].toString().replaceAll(" ", ""))
          .setData(item);
    }

    print(filmes[19].title);
  }

  uploaderGenero() async {
    var urlCategorias =
        "https://api.themoviedb.org/3/genre/movie/list?api_key=${repository.apiKey}&language=pt-BR";

    Response response = await Dio().get(urlCategorias);

    List<GeneroModel> genero = List<GeneroModel>();

    for (Map<String, dynamic> item in response.data["genres"]) {
      genero.add(GeneroModel.fromJson(item));

      var snapshots = await FirebaseFirestore.instance
          .collection("Generos")
          .document(item["id"].toString())
          .setData(item);
    }
    Navigator.pushNamed(context, "/home");
  }
}
