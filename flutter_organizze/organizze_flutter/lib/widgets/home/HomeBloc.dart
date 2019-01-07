import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:organizze_flutter/service/FirebaseAuth.dart';
import 'package:organizze_flutter/widgets/home/HomeModel.dart';

class HomeBloc {

  StreamSubscription<FirebaseUser> _streamSubscription;

  HomeModel _homeModel = HomeModel();
  HomeModel get homeModel => _homeModel;

  FirebaseServiceAuth _firebaseServiceAuth = FirebaseServiceAuth();

  StreamController<HomeModel> _streamController = StreamController();

  Sink<HomeModel> sink;

  Stream<HomeModel> stream;

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
  }

  void notifyChanges(HomeModel homeModel) {
    if ( !_streamController.isClosed ) {
      sink.add(homeModel);
    }
  }
  
  void changeCalendar(PageController pageController, String direction) {
    Duration duration = const Duration(milliseconds: 100);
    Curve curve = Curves.linear;
    int currentMonth = pageController.page.toInt();
    if (currentMonth == 0 && direction == 'left') {
      pageController.animateToPage(11, duration: Duration(milliseconds: 1), curve: curve);
      notifyChanges(_homeModel..year = _homeModel.year - 1);
    } else if (currentMonth == 11 && direction == 'right') {
      pageController.animateToPage(0, duration: Duration(milliseconds: 1), curve: curve);
      notifyChanges(_homeModel..year = _homeModel.year + 1);
    } else if (direction == 'left') {
      pageController.animateToPage(currentMonth - 1, duration: duration, curve: curve);
    } else if (direction == 'right') {
      pageController.animateToPage(currentMonth + 1, duration: duration, curve: curve);
    }
  }

  void signOut() => _firebaseServiceAuth.signOut();

}