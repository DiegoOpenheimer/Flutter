import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:marvel/model/marvel-model.dart';
import 'package:marvel/services/connectionNetwork.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:marvel/services/marvelAPI.dart';

class ModelMarvelBloc {

  Data data;
  bool isFetching;
  String message;
  ModelMarvelBloc({ this.data, this.isFetching });

}

class MarvelBloc extends BlocBase {

  int _limit = 20;
  int _offset = 0;

  MarvelAPI marvelAPI;
  ConnectionNetwork connectionNetwork;
  StreamSubscription _subscription;

  BehaviorSubject<ModelMarvelBloc> _subject = BehaviorSubject.seeded(ModelMarvelBloc(data: Data(results: List()), isFetching: false));

  ModelMarvelBloc get getInitialValue => _subject.value;

  Observable<ModelMarvelBloc> get outDataMarvel => _subject.stream;

  MarvelBloc(this.marvelAPI, this.connectionNetwork) { listenerConnectionWithNetwork(); }

  void requestCharacters() async {
    ModelMarvelBloc modelMarvelBloc = _subject.value..message = '';
    if (await connectionNetwork.connectivityResult != ConnectivityResult.none) {
     _subject.add(modelMarvelBloc..isFetching = true);
     try {
       modelMarvelBloc.data = await this.marvelAPI.getCharacters(limit: _limit, offset: _offset);
       _subject.add(modelMarvelBloc..isFetching = false);
     } catch (e) {
       _subject.add(modelMarvelBloc..isFetching = false);
     }
   } else {
     _subject.add(modelMarvelBloc..message = 'Without connection, verify network');
   }
  }

  void fetchMoreCharacters() async {
    if (await connectionNetwork.connectivityResult != ConnectivityResult.none) {
      _offset += 20;
      ModelMarvelBloc modelMarvelBloc = _subject.value;
      try {
        Data data = await this.marvelAPI.getCharacters(limit: _limit, offset: _offset);
        modelMarvelBloc.data.results.addAll(data.results);
        _subject.add(modelMarvelBloc..isFetching = false);
      } catch (e) {
        _offset -= 20;
        _subject.add(modelMarvelBloc..isFetching = false);
      }
    } else {
      //TODO show message
    }
  }

  void listenerConnectionWithNetwork() {
    _subscription = connectionNetwork.onListenConnection(listener: (ConnectivityResult result) {
      if (result != ConnectivityResult.none && _subject.value.data.results.isEmpty) {
        requestCharacters();
      }
    });
  }


  @override
  void dispose() {
    super.dispose();
    _subject.close();
    _subscription.cancel();
  }

}

