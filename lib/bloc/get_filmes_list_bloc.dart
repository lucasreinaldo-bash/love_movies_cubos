import 'package:lovemoviescubos/models/response_filme.dart';
import 'package:lovemoviescubos/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class FilmesListBloc {
  final FilmesRepository _repository = FilmesRepository();
  final BehaviorSubject<FilmeResponse> _subject =
      BehaviorSubject<FilmeResponse>();

  getFilmes() async {
    FilmeResponse response = await _repository.getFilmes();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<FilmeResponse> get subject => _subject;
}

final filmesBloc = FilmesListBloc();
