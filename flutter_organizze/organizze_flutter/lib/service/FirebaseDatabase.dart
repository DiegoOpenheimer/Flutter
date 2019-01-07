import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:organizze_flutter/model/User.dart';
import 'package:organizze_flutter/service/FirebaseAuth.dart';

class FirebaseDatabase {

  Firestore _firestore;

  FirebaseServiceAuth _firebaseServiceAuth = FirebaseServiceAuth();

  static final FirebaseDatabase _instance = FirebaseDatabase.internal();

  FirebaseDatabase.internal() {
    _firestore = Firestore.instance;
  }

  factory FirebaseDatabase() => _instance;

  void createUser(User user) async {
    try {
      FirebaseUser firebaseUser = await _firebaseServiceAuth.getCurrentUser();
      _firestore.collection("users").document(firebaseUser.uid).setData(user.toMap());
    } catch(e) {
      print(e);
    }
  }

}