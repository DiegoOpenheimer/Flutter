import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:organizze_flutter/Constants/FirebaseFailAuth.dart';


class FirebaseServiceAuth {

  FirebaseAuth _firebaseAuth;

  static FirebaseServiceAuth _instance = FirebaseServiceAuth.internal();

  FirebaseServiceAuth.internal() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  factory FirebaseServiceAuth() => _instance;

  Future<FirebaseUser> createAccount(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<FirebaseUser> signInFirebase(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<FirebaseUser> getCurrentUser() => _firebaseAuth.currentUser();

  String getMessageError(PlatformException e) {
    switch(e.message) {
      case FirebaseAuthFail.LOW_EMAIL:
        return 'Email inválido';
        break;
      case FirebaseAuthFail.EMAIL_ALREADY_USE:
        return 'Email já está sendo usado por uma outra conta';
        break;
      case FirebaseAuthFail.LOW_PASSWORD:
        return 'Senha a deve conter mais que 6 dígitos';
        break;
      case FirebaseAuthFail.USER_NOT_FOUND:
          return 'Usuário/senha incorreto';
          break;
      default:
        return 'Houve uma erro ao criar conta, certifique conexão com internet e os o formulário preenchido.';
        break;
    }
  }

  Stream<FirebaseUser> onChangeAuth() => _firebaseAuth.onAuthStateChanged;

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }


}