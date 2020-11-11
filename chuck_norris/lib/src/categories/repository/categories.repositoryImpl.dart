import 'package:dio/dio.dart';

import 'categories.repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  
  final Dio _dio;
  CancelToken _cancelToken;

  CategoriesRepositoryImpl(this._dio);


  @override
  void dispose() {
    _cancelToken?.cancel();
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      dispose();
      _cancelToken = CancelToken();
      Response response = await _dio.get('/categories', cancelToken: _cancelToken);
      return response.data.cast<String>().toList();
    } on DioError catch(e) {
      if (e?.type != DioErrorType.CANCEL) {
        throw ('Fail to get categories from server, verify network connection...');
      }
    }
    return [];
  }

  

}