import 'dart:async';
import 'package:connectivity/connectivity.dart';

import 'package:rxdart/rxdart.dart';

class ConnectionNetwork {

  static ConnectionNetwork _instance = ConnectionNetwork.internal();

  final Connectivity connectivity = Connectivity();
  final BehaviorSubject<ConnectivityResult> streamController = BehaviorSubject();

  Observable<ConnectivityResult> listenConnectionEvent;
  Sink<ConnectivityResult> emitEventer;
  StreamSubscription<ConnectivityResult> subscription;

  ConnectionNetwork.internal() {
    listenConnectionEvent = streamController.stream;
    emitEventer = streamController.sink;
    listenEvent();
  }

  factory ConnectionNetwork() => _instance;

  void listenEvent() {
    subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result) => emitEventer.add(result));
  }

  void clear() {
    streamController.close();
    emitEventer.close();
    subscription.cancel();
  }


}