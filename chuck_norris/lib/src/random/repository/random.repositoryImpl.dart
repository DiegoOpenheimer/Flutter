import 'package:chuck_norris/src/random/repository/random.repository.dart';
import 'package:dio/dio.dart';

import '../../shared/model/message.model.dart';

class RandomRepositoryImpl implements RandomRepository {
  final Dio dio;
  CancelToken _cancelToken;

  RandomRepositoryImpl(this.dio);

  @override
  Future<Message> getRandom({ String query }) async {
    try {
      Map<String, String> parameters = {};
      if (query != null && query.isNotEmpty) {
        parameters.putIfAbsent('category', () => query);
      }
      _cancelToken = CancelToken();
      Response response = await dio.get('/random', queryParameters: parameters, cancelToken: _cancelToken);
      return Message.fromJson(response.data);
    } on DioError catch (e) {
      if (e?.type != DioErrorType.CANCEL) {
        throw ('Fail to get random, verify network connection...');
      }
    }
    return null;
  }

  void dispose() {
    _cancelToken.cancel();
  }
}
