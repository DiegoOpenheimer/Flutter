// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ConsolesController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConsolesController on _ConsolesController, Store {
  final _$consolesAtom = Atom(name: '_ConsolesController.consoles');

  @override
  ObservableList<Console> get consoles {
    _$consolesAtom.context.enforceReadPolicy(_$consolesAtom);
    _$consolesAtom.reportObserved();
    return super.consoles;
  }

  @override
  set consoles(ObservableList<Console> value) {
    _$consolesAtom.context.conditionallyRunInAction(() {
      super.consoles = value;
      _$consolesAtom.reportChanged();
    }, _$consolesAtom, name: '${_$consolesAtom.name}_set');
  }

  final _$_ConsolesControllerActionController =
      ActionController(name: '_ConsolesController');

  @override
  void setConsoles(dynamic consoles) {
    final _$actionInfo = _$_ConsolesControllerActionController.startAction();
    try {
      return super.setConsoles(consoles);
    } finally {
      _$_ConsolesControllerActionController.endAction(_$actionInfo);
    }
  }
}
