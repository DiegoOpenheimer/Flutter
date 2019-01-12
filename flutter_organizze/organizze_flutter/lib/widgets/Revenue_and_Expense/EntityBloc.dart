import 'package:organizze_flutter/components/Toast.dart';
import 'package:organizze_flutter/model/Movement.dart';
import 'package:organizze_flutter/service/FirebaseDatabase.dart';
import 'dart:async';

const int START_LOADING = 1;
const int STOP_LOADING = 2;
const int STOP_LOADING_AND_GO_OUT_PAGE = 3;

class EntityBloc {

  int currentValue = STOP_LOADING;

  StreamController<int> _streamController = StreamController();

  Stream<int> stream;

  HelperToast _helperToast = HelperToast();

  FirebaseDatabase _firebaseDatabase = FirebaseDatabase();

  EntityBloc() {
    stream = _streamController.stream.asBroadcastStream();
  }

  void validateForm(Movement movement) {
    if (
      movement.value.toString().isEmpty ||
      movement.category.isEmpty ||
      movement.description.isEmpty
    ) {
      _helperToast.show('Preencha todos os campos corretamente', toastLong: true);
    } else  {
      _saveMovement(movement);
    }
  }

  void _saveMovement(Movement movement) {
    _notifyChanges(START_LOADING);
    currentValue = START_LOADING;
    _firebaseDatabase.updateRevenueAndExpense(movement)
    .then((_) {
      currentValue = STOP_LOADING_AND_GO_OUT_PAGE;
      _notifyChanges(STOP_LOADING_AND_GO_OUT_PAGE);
      _helperToast.show("Movimento salvo com sucesso");
    })
    .catchError((e) {
      print(e);
      currentValue = STOP_LOADING;
      _notifyChanges(STOP_LOADING);
      _helperToast.show("Falha ao salvar movimento", toastLong: true);
    });
  }

  void _notifyChanges(int value) {
    if (!_streamController.isClosed) {
      _streamController.add(value);
    }
  }

  void close() {
    _streamController.close();
  }

}