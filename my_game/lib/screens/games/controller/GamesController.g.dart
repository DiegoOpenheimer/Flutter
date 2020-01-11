// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GamesController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GamesController on _GamesController, Store {
  final _$gamesAtom = Atom(name: '_GamesController.games');

  @override
  ObservableList<Game> get games {
    _$gamesAtom.context.enforceReadPolicy(_$gamesAtom);
    _$gamesAtom.reportObserved();
    return super.games;
  }

  @override
  set games(ObservableList<Game> value) {
    _$gamesAtom.context.conditionallyRunInAction(() {
      super.games = value;
      _$gamesAtom.reportChanged();
    }, _$gamesAtom, name: '${_$gamesAtom.name}_set');
  }

  final _$_GamesControllerActionController =
      ActionController(name: '_GamesController');

  @override
  void setGames(List<Game> games) {
    final _$actionInfo = _$_GamesControllerActionController.startAction();
    try {
      return super.setGames(games);
    } finally {
      _$_GamesControllerActionController.endAction(_$actionInfo);
    }
  }
}
