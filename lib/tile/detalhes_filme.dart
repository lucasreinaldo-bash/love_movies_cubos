import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lovemoviescubos/data/filmes_data.dart';
import 'package:lovemoviescubos/data/genero_data.dart';
import 'package:lovemoviescubos/screen/home_screen.dart';
import 'package:lovemoviescubos/tile/filme_tile.dart';

class DetalhesFilmes extends StatefulWidget {
  FilmesData data;

  DetalhesFilmes(this.data);
  @override
  _DetalhesFilmesState createState() => _DetalhesFilmesState(this.data);
}

class _DetalhesFilmesState extends State<DetalhesFilmes> {
  FilmesData data;

  _DetalhesFilmesState(this.data);
  Color corBtnVoltar = Color(0xFF6D7070);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/home");
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Container(
                    width: 80,
                    height: 32,
                    child: Center(
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Icon(Icons.chevron_left, color: corBtnVoltar),
                              Text(
                                "Voltar",
                                style: TextStyle(
                                    fontFamily: "MontRegular",
                                    color: corBtnVoltar),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/w500/" +
                                          data.posterPath),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data.voteAverage.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF00384C),
                              fontFamily: "MontRegular",
                              fontWeight: FontWeight.w600,
                              fontSize: 24),
                        ),
                        Text(
                          " / 10",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF868e96),
                              fontFamily: "MontRegular",
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data.title.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF00384C),
                              fontFamily: "MontRegular",
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Título original: " + data.originalTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xFF00384C),
                              fontFamily: "MontRegular",
                              fontSize: 10),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Ano: ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color(0xFF868E96),
                              fontFamily: "MontRegular",
                              fontSize: 12),
                        ),
                        Text(
                          data.releaseDate.substring(0, 4),
                          style: TextStyle(
                              color: Color(0xFF343A40),
                              fontFamily: "MontRegular",
                              fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 600,
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
                                      GeneroData.fromDocument(snap.data);
                                  return Text(
                                    data.genres[index].toString() ==
                                            data.genres[0].toString()
                                        ? dataGenero.nome
                                        : "    " + dataGenero.nome,
                                    style: TextStyle(
                                      color: Color(0xFF868e96),
                                      fontSize: 10,
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Descrição: ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color(0xFF868E96),
                              fontFamily: "MontRegular",
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          data.overview,
                          style: TextStyle(
                              color: Color(0xFF343A40),
                              fontWeight: FontWeight.w600,
                              fontFamily: "MontRegular",
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  carregarOrcamento() async {}
}
