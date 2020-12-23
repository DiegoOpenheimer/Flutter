import 'dart:async';
import 'package:get/get_connect/connect.dart';

class Http extends GetConnect {

  @override
  void onInit() {
    httpClient.baseUrl = 'https://api.github.com';
  }

  Future<T> handleGet<T>(String url, {T Function(dynamic data) decoder}) async {
    Response<T> response = await get(
      url,
      decoder: decoder,
    );
    if (response.hasError) {
      if (response.statusCode != null) {
        throw (response.statusText);
      }
      throw ('Ops... Houve uma falha, verifique sua conexão com a internet');
    }
    return response.body;
  }

}