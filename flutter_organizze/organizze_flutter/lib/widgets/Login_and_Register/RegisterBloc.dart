import 'package:flutter/services.dart';
import 'package:organizze_flutter/components/Toast.dart';
import 'package:organizze_flutter/model/User.dart';
import 'dart:async';

import 'package:organizze_flutter/service/FirebaseAuth.dart';
import 'package:organizze_flutter/service/FirebaseDatabase.dart';
import 'package:organizze_flutter/widgets/Login_and_Register/RegisterModel.dart';

class RegisterBloc {

  HelperToast _helperToast = HelperToast();

  AuthWidgetModel _registerModel = AuthWidgetModel();

  FirebaseDatabase _firebaseDatabase = FirebaseDatabase();

  FirebaseServiceAuth _firebaseServiceAuth = FirebaseServiceAuth();

  StreamController<AuthWidgetModel> _streamController = StreamController();

  Sink<AuthWidgetModel> sink;

  Stream<AuthWidgetModel> stream;

  RegisterBloc() {
    sink = _streamController.sink;
    stream = _streamController.stream;
  }

  void close() {
    sink.close();
    _streamController.close();
  }

  void validateData(String name, String email, String password) {
    if ( name.isEmpty || email.isEmpty || password.isEmpty ) {
        _helperToast.show('Preencha todos os dados corretamente', toastLong: true);
    } else {
      User user = User(name, email, password, 0, 0);
      createAccount(user);
    }
  }

  void createAccount(User user) async {
    try {
      notifyChanges(_registerModel..isLoading = true);
      await _firebaseServiceAuth.createAccount(user.email, user.password);
      _helperToast.show('Conta criada com sucesso');
      _firebaseDatabase.createUser(user);
      notifyChanges(_registerModel..isLoading = false..accountCreate = true);
    } on PlatformException catch(e) {
      String message = _firebaseServiceAuth.getMessageError(e);
      notifyChanges(_registerModel..isLoading = false..messageError = message);
    } catch (e) {
      notifyChanges(_registerModel..isLoading = false..messageError = 'Houve uma erro ao criar conta, certifique conexão com internet e os o formulário preenchido.');
    }
  }

  void notifyChanges(AuthWidgetModel registerModel) {
    if (!_streamController.isClosed) {
      sink.add(registerModel);
    }
  }

}