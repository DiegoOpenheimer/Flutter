// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GameController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GameController on _GameController, Store {
  final _$currentConsoleAtom = Atom(name: '_GameController.currentConsole');

  @override
  Console get currentConsole {
    _$currentConsoleAtom.context.enforceReadPolicy(_$currentConsoleAtom);
    _$currentConsoleAtom.reportObserved();
    return super.currentConsole;
  }

  @override
  set currentConsole(Console value) {
    _$currentConsoleAtom.context.conditionallyRunInAction(() {
      super.currentConsole = value;
      _$currentConsoleAtom.reportChanged();
    }, _$currentConsoleAtom, name: '${_$currentConsoleAtom.name}_set');
  }

  final _$releaseDateAtom = Atom(name: '_GameController.releaseDate');

  @override
  DateTime get releaseDate {
    _$releaseDateAtom.context.enforceReadPolicy(_$releaseDateAtom);
    _$releaseDateAtom.reportObserved();
    return super.releaseDate;
  }

  @override
  set releaseDate(DateTime value) {
    _$releaseDateAtom.context.conditionallyRunInAction(() {
      super.releaseDate = value;
      _$releaseDateAtom.reportChanged();
    }, _$releaseDateAtom, name: '${_$releaseDateAtom.name}_set');
  }

  final _$imageAtom = Atom(name: '_GameController.image');

  @override
  Uint8List get image {
    _$imageAtom.context.enforceReadPolicy(_$imageAtom);
    _$imageAtom.reportObserved();
    return super.image;
  }

  @override
  set image(Uint8List value) {
    _$imageAtom.context.conditionallyRunInAction(() {
      super.image = value;
      _$imageAtom.reportChanged();
    }, _$imageAtom, name: '${_$imageAtom.name}_set');
  }

  final _$consolesAtom = Atom(name: '_GameController.consoles');

  @override
  List<Console> get consoles {
    _$consolesAtom.context.enforceReadPolicy(_$consolesAtom);
    _$consolesAtom.reportObserved();
    return super.consoles;
  }

  @override
  set consoles(List<Console> value) {
    _$consolesAtom.context.conditionallyRunInAction(() {
      super.consoles = value;
      _$consolesAtom.reportChanged();
    }, _$consolesAtom, name: '${_$consolesAtom.name}_set');
  }

  final _$_GameControllerActionController =
      ActionController(name: '_GameController');

  @override
  void setCurrentConsole(int value) {
    final _$actionInfo = _$_GameControllerActionController.startAction();
    try {
      return super.setCurrentConsole(value);
    } finally {
      _$_GameControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setReleaseDate(DateTime date) {
    final _$actionInfo = _$_GameControllerActionController.startAction();
    try {
      return super.setReleaseDate(date);
    } finally {
      _$_GameControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setImage(Uint8List image) {
    final _$actionInfo = _$_GameControllerActionController.startAction();
    try {
      return super.setImage(image);
    } finally {
      _$_GameControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConsoles(List<Console> consoles) {
    final _$actionInfo = _$_GameControllerActionController.startAction();
    try {
      return super.setConsoles(consoles);
    } finally {
      _$_GameControllerActionController.endAction(_$actionInfo);
    }
  }
}
