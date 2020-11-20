import 'package:lovemoviescubos/models/genero_response.dart';
import 'package:lovemoviescubos/models/response_filme.dart';
import 'package:lovemoviescubos/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GeneroListBloc {
  final FilmesRepository _repository = FilmesRepository();
  final BehaviorSubject<GeneroResponse> _subject =
      BehaviorSubject<GeneroResponse>();

  getGenero() async {
    GeneroResponse response = await _repository.getGenero();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GeneroResponse> get subject => _subject;
}

final generoBloc = GeneroListBloc();
