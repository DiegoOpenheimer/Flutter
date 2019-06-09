import 'dart:async';

import 'package:connectivity/connectivity.dart';

typedef OnListenConnection(ConnectivityResult result);
class ConnectionNetwork {

  ConnectivityResult _connectivityResult;

  Future<ConnectivityResult> get connectivityResult async {
   if (_connectivityResult == null) {
    _connectivityResult = await _connectivity.checkConnectivity();
   }
   return _connectivityResult;
  }

  Connectivity _connectivity;

  ConnectionNetwork() {
    initialize();
  }

  StreamSubscription<ConnectivityResult> onListenConnection({ OnListenConnection listener }) {
    return _connectivity.onConnectivityChanged.listen(listener);
  }

  void initialize(){
    _connectivity = Connectivity();
    _connectivity.onConnectivityChanged.listen((ConnectivityResult connection) {
      _connectivityResult = connection;
    });
  }

}