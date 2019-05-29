import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:try_bloc_pattern/widgets/MessageWidget/BlocMessage.dart';

const seconds = 7000; // 10 seconds

class GraphQLClient {

  String path = '/graphql';

  Dio dio = Dio(
    BaseOptions(
      receiveTimeout: seconds,
      connectTimeout: seconds,
      method: 'POST',
      baseUrl: 'http://192.168.0.105:3000',
      headers: {
        'content-type': 'application/graphql'
      }
    )
  );

  Future<dynamic> mutate({ @required String query }) async {
    assert( query != null || query.isNotEmpty );
    try {
      Response result = await dio.request(path, data: query);
      return result.data;
    } on DioError catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<List<Message>> query({ String query }) async {
    assert( query != null || query.isNotEmpty );
    try {
      Response result = await dio.request(path, data: query);
      if (result.data != null && result.data['data'] != null) {
        return result.data['data']['getAll'].map<Message>((value) => Message.fromMap(value)).toList();
      }
      return [];
    } on DioError catch (e) {
      print(e.toString());
      throw e;
    }
  }


}