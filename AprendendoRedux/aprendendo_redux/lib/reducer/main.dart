import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:aprendendo_redux/reducer/counterReducer.dart';

class AppState {

  int value;

  AppState(this.value);

}

Reducer<int> counterReducer = combineReducers([
  TypedReducer<int, IncrementAction>(counterIncrementReducer),
  TypedReducer<int, DecrementAction>(counterDecrementReducer)
]);

AppState appStateReducer(AppState state, action) => AppState(
    counterReducer(state.value, action)
);

Store<AppState> store = Store<AppState>(appStateReducer, initialState: AppState(0));