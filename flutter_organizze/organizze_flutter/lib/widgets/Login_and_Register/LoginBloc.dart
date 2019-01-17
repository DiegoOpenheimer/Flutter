import 'dart:async';

import 'package:organizze_flutter/components/Toast.dart';
import 'package:organizze_flutter/service/FirebaseAuth.dart';
import 'package:organizze_flutter/widgets/Login_and_Register/RegisterModel.dart';
import 'package:flutter/services.dart';



class LoginBloc {

  AuthWidgetModel _authWidgetModel = AuthWidgetModel();

  FirebaseServiceAuth _firebaseServiceAuth = FirebaseServiceAuth();

  HelperToast _helperToast = HelperToast();

  StreamController<AuthWidgetModel> _streamController = StreamController();

  Sink<AuthWidgetModel> sink;

  Stream<AuthWidgetModel> stream;

  LoginBloc() {
    sink = _streamController.sink;
    stream = _streamController.stream;
  }

  void close() {
    sink.close();
    _streamController.close();
  }

  void validateData(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      _helperToast.show('Preencha todos os dados corretamente', toastLong: true);
    } else  {
      doLogin(email, password);
    }
  }

  void doLogin(String email, String password) async {
    try {
      notifyChanges(_authWidgetModel..isLoading = true);
      await _firebaseServiceAuth.signInFirebase(email, password).timeout(const Duration(seconds: 10));
      _helperToast.show('Login efetuado com sucesso');
      notifyChanges(_authWidgetModel..isLoading = false..accountCreate = true);
    } on PlatformException catch(e) {
      String message = _firebaseServiceAuth.getMessageError(e);
      notifyChanges(_authWidgetModel..isLoading = false..messageError = message);
    } catch (e) {
      notifyChanges(_authWidgetModel..isLoading = false..messageError = 'Houve uma erro ao criar conta, certifique conexão com internet e os o formulário preenchido.');
    }
  }

  void notifyChanges(AuthWidgetModel model) {
    if ( !_streamController.isClosed ) {
      sink.add(model);
    }
  }

}