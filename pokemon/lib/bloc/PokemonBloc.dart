import 'dart:async';

import 'package:pokemon/Models/Pokemon.dart';
import 'package:pokemon/Models/PokemonModel.dart';
import 'package:pokemon/Services/ConnectionNetwork.dart';
import 'package:pokemon/Services/PokemonService.dart';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';


class PokemonBloc {

  PokemonProvider pokemonProvider = PokemonProvider();
  PokemonService pokemonService = PokemonService();
  StreamSubscription<ConnectivityResult> subscription;

  StreamController<PokemonProvider> listSteamPokemonController = StreamController();

  Stream<PokemonProvider> streamPokemon;

  Sink<PokemonProvider> sinkPokemon;


  static PokemonBloc _instance = PokemonBloc.internal();

  factory PokemonBloc() => _instance;

  PokemonBloc.internal() {
    streamPokemon = listSteamPokemonController.stream;
    sinkPokemon = listSteamPokemonController.sink;
    subscription = ConnectionNetwork().listenConnectionEvent.listen(listenEventsConnection);
  }

  void requestPokemonsFromService() async {
    try {
      pokemonProvider.pokemons = await pokemonService.getPokemons();
      pokemonProvider.hasError = false;
      pokemonProvider.isLoading = false;
      pokemonProvider.messageError = '';
      sinkPokemon.add(pokemonProvider);
    } on DioError catch(e) {
      pokemonProvider.hasError = true;
      pokemonProvider.messageError = e.message;
      sinkPokemon.add(pokemonProvider);
    }
  }

  void closeStreamController() {
    listSteamPokemonController.close();
    sinkPokemon.close();
    subscription.cancel();
  }

  void listenEventsConnection(ConnectivityResult result) {
    if (result != ConnectivityResult.none) {
      pokemonProvider.isLoading = true;
      pokemonProvider.hasError = false;
      sinkPokemon.add(pokemonProvider);
      requestPokemonsFromService();
    }
  }

  Future<Pokemon> requestPokemonById(PokemonModel pokemonModel) async {
    try {
      Pokemon pokemon = await pokemonService.getPokemonById(pokemonModel.url.split('/')[6]);
      return pokemon;
    } on DioError catch(error) {
      print('ERROR BLOCK');
      throw error;
    }
  }

}

class PokemonProvider {

  String _messageError;
  bool _hasError;
  bool _isLoading;
  bool _isFetchingPokemon;
  List<PokemonModel> _pokemons;

  PokemonProvider([String messageError, bool hasError, bool isLoading, List<PokemonModel> pokemons]) :
    this._messageError = messageError, this._hasError = hasError, this._isLoading = isLoading, this._pokemons = pokemons ?? List();

  List<PokemonModel> get pokemons => _pokemons;

  set pokemons(List<PokemonModel> value) {
    _pokemons = value;
  }

  bool get hasError => _hasError;

  set hasError(bool value) {
    _hasError = value;
  }

  String get messageError => _messageError;

  set messageError(String value) {
    _messageError = value;
  }

  bool get isLoading => _isLoading;

  void set isLoading(bool isLoading) => _isLoading = isLoading;

  bool get isFetchingPokemon => _isFetchingPokemon;

  void set isFetchingPokemon(bool value) => _isFetchingPokemon = value;


}
