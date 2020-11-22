import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lovemoviescubos/data/filmes_data.dart';
import 'package:lovemoviescubos/data/genero_data.dart';
import 'package:lovemoviescubos/repository/repository.dart';

import 'detalhes_filme.dart';

class FilmeTile extends StatefulWidget {
  FilmesData data;

  FilmeTile(this.data);

  @override
  _FilmeTileState createState() => _FilmeTileState(this.data);
}

class _FilmeTileState extends State<FilmeTile> {
  FilmesData data;

  _FilmeTileState(this.data);
  FilmesRepository repository;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => DetalhesFilmes(data)));
        },
        child: Stack(
          children: [
            Container(
              height: 400,
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    Container(
                      height: 400,
                      width: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://image.tmdb.org/t/p/w500/" +
                                  data.posterPath),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, bottom: 20),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  " " + data.title.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 20,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.genres.length,
                                  itemBuilder: (_, index) {
                                    return StreamBuilder(
                                      stream: Firestore.instance
                                          .collection("Generos")
                                          .doc(data.genres[index].toString())
                                          .snapshots(),
                                      builder: (context, snap) {
                                        if (!snap.hasData) {
                                          return LinearProgressIndicator();
                                        } else {
                                          GeneroData dataGenero =
                                              GeneroData.fromDocument(
                                                  snap.data);
                                          return Text(
                                            data.genres[index].toString() ==
                                                    data.genres[0].toString()
                                                ? dataGenero.nome
                                                : " - " + dataGenero.nome,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
