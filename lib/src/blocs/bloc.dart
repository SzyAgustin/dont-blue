import 'dart:async';

class Bloc {
  final _tap = StreamController();

  get tapAnimations => _tap.sink.add;
  get excecAnimations => _tap.stream;

  dispose() {
    _tap.close();
  }
}

final bloc = Bloc();
