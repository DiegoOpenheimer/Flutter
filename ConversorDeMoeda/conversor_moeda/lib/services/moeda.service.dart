import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MoedaService {

  final String url = 'https://api.hgbrasil.com/finance?format=json&key=60df7606';

  Future<Map> getData() {
    return http.get(url)
          .then((http.Response response) => json.decode(response.body));
  }

}