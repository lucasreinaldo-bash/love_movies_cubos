import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lovemoviescubos/data/filmes_data.dart';
import 'package:lovemoviescubos/data/genero_data.dart';
import 'package:lovemoviescubos/models/filmes_model.dart';
import 'package:lovemoviescubos/models/genero_model.dart';
import 'package:lovemoviescubos/models/movie_model.dart';
import 'package:lovemoviescubos/repository/repository.dart';
import "package:lovemoviescubos/style/theme.dart" as Style;
import 'package:lovemoviescubos/tile/filme_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

//      print(item);

class _HomeScreenState extends State<HomeScreen> {
  var title;
  final _pesquisarController = TextEditingController();
  final FocusNode myFocusPesquisa = FocusNode();
  String filtro;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //Colors
  Color colorBusca = Color(0xFFF1F3F5);
  Color colorSearch = Color(0xFF5E6770);
  Color colorCard = Color(0xFF00384C);
  Color colorCardFiltro = Color(0xFF00384C);
  Color colorFloating = Color(0xFF4388F8);
  int categoria_id;
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
              Text(
                " Filmes",
                style: TextStyle(
                    fontFamily: "MontRegular",
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              SizedBox(
                height: 30,
              ),
              Card(
                elevation: 5,
                color: colorBusca,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: TextField(
                  onEditingComplete: () {
                    setState(() {});
                    String pesquisaDigitada = _pesquisarController.text.trim();
                    List<String> pesquisaRetirada;

                    pesquisaRetirada = pesquisaDigitada.split(" ");

                    initState();
                  },
                  focusNode: myFocusPesquisa,
                  controller: _pesquisarController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "MontRegular",
                      fontSize: 14.0,
                      color: Colors.black),
                  decoration: InputDecoration(
                    prefixIcon: InkWell(
                      child: Icon(
                        CupertinoIcons.search,
                        color: colorSearch,
                        size: 20.0,
                      ),
                    ),
                    border: InputBorder.none,
                    hintText: "Pesquise Filmes",
                    hintStyle: TextStyle(fontFamily: "Georgia", fontSize: 14.0),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 45,
                child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("Generos")
                      .orderBy("name", descending: false)
                      .get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: LinearProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (_, index) {
                            GeneroData data = GeneroData.fromDocument(
                                snapshot.data.documents[index]);

                            String genero = data.nome;
                            int id = data.id;

                            if (categoria_id == 0) {
                              categoria_id == data.id;
                            }
                            return InkWell(
                              child: filtro == data.nome
                                  ? Card(
                                      color: filtro == data.nome
                                          ? colorCardFiltro
                                          : Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(26)),
                                      child: Container(
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Center(
                                            child: Text(
                                              genero,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: "MontRegular",
                                                  fontSize: 12,
                                                  color: filtro == data.nome
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 70,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Center(
                                          child: Text(
                                            genero,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "MontRegular",
                                                fontSize: 12,
                                                color: filtro == data.nome
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                              onTap: () {
                                setState(() {
                                  categoria_id = data.id;
                                  filtro = data.nome;
                                });

                                initState();
                              },
                            );
                          });
                    }
                  },
                ),
              ),
              Container(
                width: 500,
                height: 400,
                child: _pesquisarController.text.length > 2
                    ? FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("Filmes")
                            .where("title",
                                isEqualTo: _pesquisarController.text)
                            .get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: LinearProgressIndicator(),
                            );
                          } else {
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (_, index) {
                                  FilmesData data = FilmesData.fromDocument(
                                      snapshot.data.documents[index]);

                                  return FilmeTile(data);
                                });
                          }
                        },
                      )
                    : FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("Filmes")
                            .orderBy("title", descending: false)
                            .where("genre_ids", arrayContains: categoria_id)
                            .get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: LinearProgressIndicator(),
                            );
                          } else {
                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (_, index) {
                                  FilmesData data = FilmesData.fromDocument(
                                      snapshot.data.documents[index]);

                                  return FilmeTile(data);
                                });
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
