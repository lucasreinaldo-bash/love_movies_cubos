import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lovemoviescubos/models/filmes_model.dart';
import 'package:lovemoviescubos/models/movie_model.dart';
import "package:lovemoviescubos/style/theme.dart" as Style;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//      print(item);

class _HomeScreenState extends State<HomeScreen> {
  var title;
  openStartPage() async {
    var dataStr = jsonEncode({
      "command": "get_products",
    });

    var url =
        "https://api.themoviedb.org/3/movie/now_playing?api_key=73d0e926f349bfb4d8211828e4292640&language=pt-BR";

    Response response = await Dio().get(url);

    List<MovieModel> filmes = List<MovieModel>();

    for (Map<String, dynamic> item in response.data["results"]) {
      filmes.add(MovieModel.fromJson(item));
    }
    print(filmes[19].title);

//    print(response.data);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openStartPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        title: Text(title.toString()),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
