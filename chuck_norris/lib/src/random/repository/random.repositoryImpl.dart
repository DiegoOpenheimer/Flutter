import 'package:chuck_norris/src/random/repository/random.repository.dart';
import 'package:dio/dio.dart';

import '../random.model.dart';

class RandomRepositoryImpl implements RandomRepository {
  final Dio dio;
  CancelToken _cancelToken;

  RandomRepositoryImpl(this.dio);

  @override
  Future<Random> getRandom() async {
    try {
      _cancelToken = CancelToken();
      Response response = await dio.get('/random', cancelToken: _cancelToken);
      return Random.fromJson(response.data);
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
