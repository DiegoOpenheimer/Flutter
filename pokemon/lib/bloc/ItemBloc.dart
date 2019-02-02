import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:pokemon/Models/item.dart';
import 'package:pokemon/Services/ConnectionNetwork.dart';
import 'package:pokemon/Services/PokemonService.dart';
import 'package:rxdart/rxdart.dart';

class ItemBloc {

  static ItemBloc _instance = ItemBloc.internal();
  PokemonService pokemonService = PokemonService();
  ItemProvider itemProvider = ItemProvider();
  StreamSubscription<ConnectivityResult> subscription;
  BehaviorSubject<ItemProvider> _subject = BehaviorSubject();
  Observable<ItemProvider> streamItem;
  Sink<ItemProvider> sinkItem;

  int offset = 0;

  ItemBloc.internal() {
    _subject.value = itemProvider;
    streamItem = _subject.stream;
    sinkItem = _subject.sink;
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

  void fetchingMoreItems() async {
    offset+=20;
    try {
      sinkItem.add(itemProvider..isFetchingItems = true);
      List<ItemModel> items = await pokemonService.getItems(offset: offset);
      itemProvider.items.addAll(items);
      sinkItem.add(itemProvider..isFetchingItems = false);
    } on DioError catch(e) {
      print('ERROR DIO $e');
      sinkItem.add(itemProvider..isFetchingItems = false);
    }
  }

  void closeStreams() {
    _subject.close();
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
  bool _isFetchingItems = false;

  ItemProvider([bool hasError, List<ItemModel> items]) : this._hasError = hasError ?? false, this._items = items ?? List();

  List<ItemModel> get items => _items;

  set items(List<ItemModel> value) {
    _items = value;
  }

  bool get hasError => _hasError;

  set hasError(bool value) {
    _hasError = value;
  }

  bool get isFetchingItems => _isFetchingItems;

  set isFetchingItems(bool value) {
    _isFetchingItems = value;
  }


}