import 'package:chuck_norris/src/shared/LoadingRequest.dart';
import 'package:chuck_norris/src/shared/model/message.model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class SearchViewModel with LoadingRequest {
  final Dio _dio;
  RxList<Message> messages = <Message>[].obs;
  Rx<Message> messageSelected = Rx();
  CancelToken _cancelToken;
  String _lastQuery;

  SearchViewModel(this._dio);

  Future<void> load(String query) async {
    if (query.isNotEmpty && query.length >= 3 && _lastQuery != query) {
      try {
        handleRequest(loading: true);
        _cancelToken?.cancel();
        _cancelToken = CancelToken();
        Response response = await _dio.get('/search',
            queryParameters: {'query': query}, cancelToken: _cancelToken);
        if (response.data['result'] != null) {
          messages.value = response.data['result']
              .map<Message>((value) => Message.fromJson(value))
              .toList();
          _lastQuery = query;
        }
        handleRequest(loading: false);
      } on DioError catch (e) {
        if (e?.type != DioErrorType.CANCEL) {
          handleRequest(
              loading: false,
              error: 'Fail to query, verify network connection...');
        } else {
          handleRequest(loading: false);
        }
      }
    }
  }

  void dispose() {
    _cancelToken?.cancel();
  }
}
