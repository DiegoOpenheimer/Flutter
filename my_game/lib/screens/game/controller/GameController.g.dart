// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GameController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GameController on _GameController, Store {
  final _$currentConsoleAtom = Atom(name: '_GameController.currentConsole');

  @override
  String get currentConsole {
    _$currentConsoleAtom.context.enforceReadPolicy(_$currentConsoleAtom);
    _$currentConsoleAtom.reportObserved();
    return super.currentConsole;
  }

  @override
  set currentConsole(String value) {
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

  final _$_GameControllerActionController =
      ActionController(name: '_GameController');

  @override
  void setCurrentConsole(String value) {
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
}
