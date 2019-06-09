import 'package:dio/dio.dart';
import 'package:marvel/model/marvel-model.dart';
import 'package:marvel/utils/Formatter.dart';

const int timeout = 5000;

const String apikey = '4dc572fd2a705860fabc560e57fa2ba9';
const String privateKey = '1599c9b56b2d6766c5466371ca404d784310ab69';

class MarvelAPI {

  Dio _dio = Dio(
    BaseOptions(
      method: 'GET',
      connectTimeout: timeout,
      receiveTimeout: timeout,
      baseUrl: 'https://gateway.marvel.com/v1/public/',
    )
  );
  
  Future<Data> getCharacters({ int limit, int offset }) async {
    Map parameters = Formatter.buildQueryParameters(apikey: apikey, privateKey: privateKey, limit: limit, offset: offset);
    _setQueryParameters( parameters );
    try {
      Response response = await _dio.request('characters');
      if ( response.data['data'] != null ) {
          return Data.fromMap(response.data['data']);
      }
      return null;
    } on DioError catch ( e ) {
      throw e.message;
    }
  }

  void _setQueryParameters(Map<String, dynamic> parameters) {
    _dio.options.queryParameters = parameters;
  }

}