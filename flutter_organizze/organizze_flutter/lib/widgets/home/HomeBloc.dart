import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:organizze_flutter/components/Toast.dart';
import 'package:organizze_flutter/model/Movement.dart';
import 'package:organizze_flutter/model/User.dart';
import 'package:organizze_flutter/service/FirebaseAuth.dart';
import 'package:organizze_flutter/service/FirebaseDatabase.dart';
import 'package:organizze_flutter/widgets/home/HomeModel.dart';

class HomeBloc {

  StreamSubscription<FirebaseUser> _streamSubscription;

  StreamSubscription _subscriptionMovements;

  StreamSubscription _subscriptionUser;

  HomeModel _homeModel = HomeModel();
  HomeModel get homeModel => _homeModel;

  FirebaseServiceAuth _firebaseServiceAuth = FirebaseServiceAuth();

  FirebaseDatabase _firebaseDatabase = FirebaseDatabase();

  StreamController<HomeModel> _streamController = StreamController();

  Sink<HomeModel> sink;

  Stream<HomeModel> stream;

  HelperToast _helperToast = HelperToast();

  HomeBloc() {
    stream = _streamController.stream.asBroadcastStream();
    sink = _streamController.sink;
  }

  void addListenerAuthOnChange() {
    _streamSubscription = _firebaseServiceAuth.onChangeAuth().listen((FirebaseUser firebaseUser) {
        if ( firebaseUser == null ) {
          notifyChanges(_homeModel..userIsConnected = false);
        }
    });
  }

  void close() {
    _streamSubscription.cancel();
    _streamController.close();
    sink.close();
    if (_subscriptionMovements != null) {
      _subscriptionMovements.cancel();
    }
    if (_subscriptionUser != null) {
      _subscriptionUser.cancel();
    }
  }

  void notifyChanges(HomeModel homeModel) {
    if ( !_streamController.isClosed ) {
      sink.add(homeModel);
    }
  }
  
  void changeCalendar(PageController pageController, String direction) {
    Duration duration = const Duration(milliseconds: 100);
    int month;
    Curve curve = Curves.linear;
    int currentMonth = pageController.page.toInt();
    month = currentMonth;
    if (currentMonth == 0 && direction == 'left') {
      pageController.animateToPage(11, duration: Duration(milliseconds: 1), curve: curve);
      notifyChanges(_homeModel..year = _homeModel.year - 1);
      month = 12;
    } else if (currentMonth == 11 && direction == 'right') {
      pageController.animateToPage(0, duration: Duration(milliseconds: 1), curve: curve);
      notifyChanges(_homeModel..year = _homeModel.year + 1);
      month = 1;
    } else if (direction == 'left') {
      pageController.animateToPage(currentMonth - 1, duration: duration, curve: curve);
    } else if (direction == 'right') {
      pageController.animateToPage(currentMonth + 1, duration: duration, curve: curve);
      month = currentMonth + 2;
    }
    _homeModel.currentKey = '''$month${_homeModel.year}''';
    listenMovements();
  }

  void signOut() => _firebaseServiceAuth.signOut();

  void listenMovements() async {
    notifyChanges(_homeModel..loadListMovements = true..movements.clear());
    if (_subscriptionMovements != null) {
      await _subscriptionMovements.cancel();
    }
    Stream<QuerySnapshot> stream = await _firebaseDatabase.listenMovements(_homeModel.currentKey);
    _subscriptionMovements = stream.listen((QuerySnapshot snaphot) {
      if (snaphot.documents.isNotEmpty) {
        _homeModel.movements = List();
        snaphot.documents.forEach((DocumentSnapshot document) {
         _homeModel.movements.add(Movement.fromMap(document.data)..id = document.documentID);
        });
        notifyChanges(_homeModel);
      }
      notifyChanges(_homeModel..loadListMovements = false);
    });
    _subscriptionMovements.onError((value) => notifyChanges(_homeModel..loadListMovements = false));
    _subscriptionMovements.onDone(() => notifyChanges(_homeModel..loadListMovements = false));
  }

  void listenUser() async {
    if (_subscriptionUser != null) {
      _subscriptionUser.cancel();
    }
    notifyChanges(_homeModel..loadUser = true);
    Stream<DocumentSnapshot> stream = await _firebaseDatabase.listenUser();
    _subscriptionUser = stream.listen((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        notifyChanges(
            _homeModel
              ..loadUser = true
              ..user = User.fromMap(snapshot.data)
        );
      }
      notifyChanges(_homeModel..loadUser = false);
    });
    _subscriptionUser.onDone(() => this.notifyChanges(_homeModel..loadUser = false));
    _subscriptionUser.onError((value) => this.notifyChanges(_homeModel..loadUser = false));
  }

  void removeItemTemporarily(int index) {
    _homeModel.movements.removeAt(index);
    notifyChanges(_homeModel);
  }

  void removeItem(int index, Movement movement) async {
    try {
      notifyChanges(_homeModel);
      await _firebaseDatabase.removeMovement(movement);
      _firebaseDatabase.updateUserAfterRemoveMovement(movement);
      _helperToast.show("Movimentação excluída com sucesso");
    } catch(e) {
      print(e);
      _homeModel.movements.insert(index, movement);
      notifyChanges(_homeModel);
      _helperToast.show("Erro ao excluir movimentação ${movement.category}", toastLong: true);
    }
  }

  void cancelRemoveItem(int index, Movement movement) {
    _homeModel.movements.insert(index, movement);
    notifyChanges(_homeModel);
  }

}