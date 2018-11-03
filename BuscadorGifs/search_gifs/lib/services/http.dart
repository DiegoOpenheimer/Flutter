import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Http {

  String URL_RATING = 'https://api.giphy.com/v1/gifs/trending?api_key=yuNUb9s4I7x9Fnh3FqeEa7G3XUUbpzJC&limit=20&rating=G';

  Future<dynamic> getGifs() {
    return http.get(URL_RATING).then((http.Response response) => json.decode(response.body)).catchError(print);
  }

  Future<dynamic> searchGifs(String name, int offset) {
    String URL_SEARCH = 'https://api.giphy.com/v1/gifs/search?api_key=yuNUb9s4I7x9Fnh3FqeEa7G3XUUbpzJC&q=$name&limit=20&offset=$offset&rating=G&lang=en';
    return http.get(URL_SEARCH).then((http.Response response) => json.decode(response.body)).catchError(print);
  }

}