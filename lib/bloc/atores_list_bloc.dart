import 'package:lovemoviescubos/models/atores_response.dart';
import 'package:lovemoviescubos/models/genero_response.dart';
import 'package:lovemoviescubos/models/response_filme.dart';
import 'package:lovemoviescubos/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class AtoresListBloc {
  final FilmesRepository _repository = FilmesRepository();
  final BehaviorSubject<AtoresResponse> _subject =
      BehaviorSubject<AtoresResponse>();

  getGenero(int id) async {
    AtoresResponse response = await _repository.getAtores();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<AtoresResponse> get subject => _subject;
}

final atoresBloc = AtoresListBloc();
