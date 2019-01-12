import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:organizze_flutter/Utils/DateCustom.dart';
import 'package:organizze_flutter/model/Movement.dart';
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
      _firestore
          .collection("users")
          .document(firebaseUser.uid)
          .setData(user.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateRevenueAndExpense(Movement movement) async {
    FirebaseUser firebaseUser = await _firebaseServiceAuth.getCurrentUser();
    DocumentSnapshot snapshot =
        await _firestore.collection("users").document(firebaseUser.uid).get();
    if (snapshot.exists) {
      double value = movement.value;
      User user = User.fromMap(snapshot.data);
      if (movement.type == 'r') {
        user.totalIncoming = user.totalIncoming + value;
      } else {
        user.totalExpenditure = user.totalExpenditure + value;
      }
      snapshot.reference.updateData(user.toMap());
      String key = DateCustom.generateKeyDateWithMonthAndYear(movement.date);
      return await _firestore
          .collection("movements")
          .document(firebaseUser.uid)
          .collection(key)
          .add(movement.toMap())
          .timeout(const Duration(seconds: 5));
    } else {
      throw ArgumentError("Without data");
    }
  }

  Future<Stream<QuerySnapshot>> listenMovements(String key) async {
    FirebaseUser firebaseUser = await _firebaseServiceAuth.getCurrentUser();
    return _firestore.collection("movements")
    .document(firebaseUser.uid)
    .collection(key)
    .snapshots();
  }
}
