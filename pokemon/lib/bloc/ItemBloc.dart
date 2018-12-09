import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:pokemon/Models/item.dart';
import 'package:pokemon/Services/ConnectionNetwork.dart';
import 'package:pokemon/Services/PokemonService.dart';

class ItemBloc {

  static ItemBloc _instance = ItemBloc.internal();
  PokemonService pokemonService = PokemonService();
  ItemProvider itemProvider = ItemProvider();
  StreamSubscription<ConnectivityResult> subscription;
  StreamController<ItemProvider> streamController = StreamController();
  Stream<ItemProvider> streamItem;
  Sink<ItemProvider> sinkItem;

  ItemBloc.internal() {
    streamItem = streamController.stream.asBroadcastStream();
    sinkItem = streamController.sink;
    subscription = ConnectionNetwork().listenConnectionEvent.listen(listenEventsToChangeConnection);
  }
  factory ItemBloc() => _instance;

  void requestServiceToGetItems() async {
    try {
      itemProvider.items = await pokemonService.getItems();
      itemProvider.hasError = false;
      sinkItem.add(itemProvider);
    } on DioError catch(e) {
      itemProvider.hasError = true;
      sinkItem.add(itemProvider);
    }
  }

  void closeStreams() {
    streamController.close();
    sinkItem.close();
    subscription.cancel();
  }

  void listenEventsToChangeConnection(ConnectivityResult result) {
    if (result != ConnectivityResult.none) {
      requestServiceToGetItems();
    }
  }

}


class ItemProvider {

  bool _hasError;
  List<ItemModel> _items;

  ItemProvider([bool hasError, List<ItemModel> items]) : this._hasError = hasError ?? false, this._items = items ?? List();

  List<ItemModel> get items => _items;

  set items(List<ItemModel> value) {
    _items = value;
  }

  bool get hasError => _hasError;

  set hasError(bool value) {
    _hasError = value;
  }


}