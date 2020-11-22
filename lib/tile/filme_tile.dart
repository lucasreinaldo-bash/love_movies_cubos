import 'package:flutter/material.dart';
import 'package:lovemoviescubos/data/filmes_data.dart';
import 'package:lovemoviescubos/repository/repository.dart';

class FilmeTile extends StatelessWidget {
  FilmesData data;

  FilmeTile(this.data);
  FilmesRepository repository;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
      height: 470,
      width: 320,
      child: Card(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
            Stack(
              children: <Widget>[
                Image.network(
                  "https://image.tmdb.org/t/p/w500/" + data.posterPath,
                  fit: BoxFit.cover,
                ),
              ],
            )
          ])),
    ));
  }
}
