import 'dart:async';
import 'package:get/get_connect/connect.dart';
import 'package:test_get_connect/src/github/model/repository.dart';
import 'github.repository.dart';

class GitHubRepositoryImpl extends GetConnect implements GitHubRepository {

  @override
  void onInit() {
    httpClient.baseUrl = 'https://api.github.com/users';
  }

  Future<List<Repository>> getRepositories(String name) async {
    Response response = await get(
      '/$name/repos',
      decoder: (response) {
        try {
          var value = response?.map<Repository>((json) => Repository.fromJson(json))?.toList() ?? [];
          return value;
        } catch (e) {
          return [];
        }
      },
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