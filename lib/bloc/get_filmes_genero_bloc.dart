import 'package:flutter/material.dart';
import 'package:lovemoviescubos/models/genero_response.dart';
import 'package:lovemoviescubos/models/response_filme.dart';
import 'package:lovemoviescubos/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetFilmesGeneroBloc {
  final FilmesRepository _repository = FilmesRepository();
  final BehaviorSubject<FilmeResponse> _subject =
      BehaviorSubject<FilmeResponse>();

  getGenero(int id) async {
    FilmeResponse response = await _repository.getFilmesPorGenero(id);
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    _subject.close();
  }

  BehaviorSubject<FilmeResponse> get subject => _subject;
}

final generoBloc = GetFilmesGeneroBloc();
