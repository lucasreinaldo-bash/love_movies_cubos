import 'package:lovemoviescubos/models/genero_response.dart';
import 'package:lovemoviescubos/models/response_filme.dart';
import 'package:lovemoviescubos/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetPlayingBloc {
  final FilmesRepository _repository = FilmesRepository();
  final BehaviorSubject<FilmeResponse> _subject =
      BehaviorSubject<FilmeResponse>();

  getPlaying() async {
    FilmeResponse response = await _repository.getPlayingFilmes();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<FilmeResponse> get subject => _subject;
}

final playingBloc = GetPlayingBloc();
