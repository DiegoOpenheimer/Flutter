import 'package:dio/dio.dart';
import 'package:pokemon/Models/Pokemon.dart';
import 'package:pokemon/Models/item.dart';
import 'package:pokemon/Models/PokemonModel.dart';


class PokemonService {

  final Dio dio = Dio(Options(baseUrl: 'https://pokeapi.co/api/v2/'));

  Future<List<PokemonModel>> getPokemons() {
    return dio.get('pokemon').timeout(const Duration(seconds: 10))
        .then((Response response) {
            List data = response.data['results'];
            return data.map((pokemon) => PokemonModel.fromJson(pokemon)).toList();
        });
  }

  Future<List<ItemModel>> getItems() {
    return dio.get('item').timeout(const Duration(seconds: 10)).then((Response response) {
      List items = response.data['results'];
      return items.map((item) => ItemModel.fromMap(item)).toList();
    });
  }

  Future<Pokemon> getPokemonById(String id) {
    return dio.get('pokemon/$id')
        .then((Response response) => Pokemon.fromJson(response.data));
  }

  Future getItemById(String id) {
    return dio.get('item/$id')
        .then((Response response) => response.data);
  }

}